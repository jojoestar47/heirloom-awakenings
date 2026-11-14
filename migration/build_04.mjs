// Builds 04_descriptions.sql from 04_descriptions.json (the reviewable source).
// Run: node migration/build_04.mjs
import fs from 'fs';
const rows = JSON.parse(fs.readFileSync(new URL('./04_descriptions.json', import.meta.url), 'utf8'));
const q = s => `'${s.replace(/'/g, "''")}'`;
const arr = a => `array[${a.map(q).join(',')}]::text[]`;
const values = rows.map(r => `  (${q(r.id)}, ${arr(r.tags)}, ${q(r.effect)})`).join(',\n');
const sql = `-- Heirloom Awakenings — rewrite every awakening in the "tags + short bullets" style.
-- Generated from 04_descriptions.json by build_04.mjs; edit the JSON, not this file.
--
-- effect: short lines, "- " starts a bullet, **text** is bold (rendered by index.html).
-- tags:   when/how it's used (Action, Reaction, 1 minute, Short or long rest, ...).

begin;

alter table public.ha_upgrades add column if not exists tags text[] not null default '{}';

update public.ha_upgrades as u set tags = v.tags, effect = v.effect
from (values
${values}
) as v(id, tags, effect)
where u.id = v.id;

-- Heirlooms in this campaign aren't always weapons.
update public.ha_upgrades set name = replace(name, 'Enhanced Weapon', 'Enhanced Heirloom')
where name like 'Enhanced Weapon%';

commit;
`;
fs.writeFileSync(new URL('./04_descriptions.sql', import.meta.url), sql);
console.log(`wrote ${rows.length} rows`);
