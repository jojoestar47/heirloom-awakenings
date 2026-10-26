-- Heirloom Awakenings — align ha_upgrades with "Ancestral Weapons" v1.2 (Dungeon Rollers)
--
-- Audit of all 146 rows against the PDF found:
--   * Tier IV "limited" section was wrong: it held 20 copies of Tier III upgrades
--     (ids ending _t4) marked limited, while the 8 real Tier IV limited upgrades
--     were missing entirely.
--   * Quick cost 3 SP; the PDF says 1 SP.
--   * Unflinching carried a "Ranged attacks" requirement the PDF doesn't have.
--   * Several effects were missing rules that matter at the table
--     (rest recharges, save details, damage-type lists, Indomitable using a reaction).
--
-- Safe to re-run. The deletes skip any row a character has already taken.

begin;

-- 1. Remove the mistaken Tier IV duplicates of Tier III upgrades.
delete from public.ha_upgrades u
where u.id in (
  'blindside_level_2_t4','blood_drinker_level_1_t4','brawn_t4','charged_smite_level_2_t4',
  'distracting_level_2_t4','elemental_manipulation_t4','elemental_resistance_t4','focused_t4',
  'hardy_t4','indomitable_level_2_t4','lashing_t4','nemesis_t4','proficient_level_3_t4',
  'rapid_strike_t4','shimmering_t4','spelleater_t4','spellhunter_t4','sustaining_t4',
  'tracking_t4','will_level_1_t4'
)
and not exists (select 1 from public.ha_character_awakenings a where a.upgrade_id = u.id);

-- 2. Add the real Tier IV limited upgrades.
-- The PDF prints the Tier IV spell-storing entry as "(level 4)" twice; the Tier IV
-- one stores a level 5 spell, so it is named "(level 5)" here.
insert into public.ha_upgrades (id, name, tier, min_level, cost, repeatable, requirements_note, effect, sort_order) values
  ('amplify_level_2_t4',       'Amplify (level 2)',       4, 15, 10, true, null,           'You gain +2 to an ability score of your choice (maximum of 20).', 110),
  ('guardian_level_2_t4',      'Guardian (level 2)',      4, 15,  7, true, null,           'You gain proficiency in a saving throw of your choice. If you can see the source of the effect, you also have advantage on those saves.', 111),
  ('keen_level_2_t4',          'Keen (level 2)',          4, 15, 10, true, null,           'The weapon scores a critical hit on a d20 roll of 18, 19 or 20.', 112),
  ('magical_core_level_4_t4',  'Magical Core (level 4)',  4, 15,  8, true, null,           'Choose a level 1 spell; cast it from the weapon at will as an action (+8 attack, DC 16).', 113),
  ('slayer_level_2_t4',        'Slayer (level 2)',        4, 15, 10, true, null,           'Choose an enemy type (beasts, fey, humanoids, monstrosities or undead); weapon attacks deal 4d6 additional damage to that type.', 114),
  ('spell_link_level_4_t4',    'Spell Link (level 4)',    4, 15,  8, true, 'Spellcasters', 'Gain one additional level 4 spell slot, which refreshes on a long rest.', 115),
  ('spell_storing_level_5_t4', 'Spell Storing (level 5)', 4, 15, 10, true, null,           'Choose a level 5 spell; cast it from the weapon once per long rest (+8 attack, DC 16).', 116),
  ('truesight_t4',             'Truesight',               4, 15, 10, true, null,           'You have truesight while holding this weapon.', 117)
on conflict (id) do update set
  name = excluded.name, tier = excluded.tier, min_level = excluded.min_level, cost = excluded.cost,
  repeatable = excluded.repeatable, requirements_note = excluded.requirements_note,
  effect = excluded.effect, sort_order = excluded.sort_order;

-- 3. Cost / requirement fixes.
update public.ha_upgrades set cost = 1 where id = 'quick_t1';
update public.ha_upgrades set requirements_note = null where id = 'unflinching_t1';

-- 4. Effect wording fixes.
update public.ha_upgrades as u set effect = v.effect
from (values
  ('bully_t1',                   'Gain advantage on Charisma (Intimidation) checks when the target can see you and you are holding the weapon.'),
  ('indomitable_level_1_t1',     'When you are reduced to 0 HP, immediately make one attack with this weapon before falling unconscious.'),
  ('infusion_level_1_t1',        'Choose a damage type (acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant or thunder); weapon attacks deal an additional d6 damage of that type.'),
  ('slayer_level_1_t1',          'Choose an enemy type (beasts, fey, humanoids, monstrosities or undead); weapon attacks deal 2d6 additional damage to that type.'),
  ('overpower_disarming_t1',     'On a roll of 19-20, target makes DC 14 Str save or drops one held item of your choice (advantage on the save if it holds the item with two or more hands).'),
  ('overpower_dread_t1',         'On a roll of 19-20, target makes DC 14 Wis save or is frightened of you for 1 minute (repeats the save at the end of each of its turns).'),
  ('overpower_hamstring_t1',     'On a roll of 19-20, target makes DC 14 Dex save or its speed is halved until your next turn.'),
  ('overpower_poisonous_t1',     'On a roll of 19-20, target makes DC 14 Con save or is poisoned (repeats the save at the end of each of its turns).'),
  ('ritualist_t1',               'Time to ritual cast spells is halved while the weapon is in your possession.'),
  ('divine_grace_t2',            'Spend 10 minutes communing with your deity; within the next 24 hours, reroll any one die (must take the second result). Commune again after a short or long rest.'),
  ('en_guard_t2',                'When you or an ally within 5ft is targeted by an attack you can see, use your reaction for one: +5 AC against that attack, move up to your speed without provoking, make a melee attack against the attacker, or gain advantage against it until the end of your next turn (once per short or long rest).'),
  ('hunter_s_watch_t2',          'Reaction: make an opportunity attack against a creature moving within 30ft. If it hits, the target makes a DC 14 Dex save or its speed becomes 0 (once per short or long rest).'),
  ('reverberation_t2',           'Expend a Bardic Inspiration on an attack; if it deals damage, the target makes a Wis save against your spell DC or is charmed or frightened by you (your choice) for 1 minute, repeating the save at the end of each of its turns.'),
  ('sprightly_t2',               'Bonus action: gain advantage on your next attack roll. If that attack hits, you can''t use this again until you finish a short or long rest.'),
  ('underhanded_t2',             'Reaction: a melee attack against you or an ally within 5ft is made at disadvantage. If it misses, you can''t use this again until you finish a short or long rest.'),
  ('will_of_the_ancestors_t2',   'Action: each enemy within 15ft makes a DC 14 Wis save, taking 2d8 psychic damage on a failure or half on a success (once per short or long rest).'),
  ('elemental_manipulation_t3',  'When you cast a spell with a slot that deals acid, cold, fire, force, lightning, necrotic, radiant or thunder damage, swap one of its damage types for another from that list.'),
  ('elemental_resistance_t3',    'Choose a damage type (fire, cold, lightning, radiant, thunder, necrotic, force, psychic or poison); you gain resistance to it.'),
  ('infusion_level_2_t3',        'Choose a damage type (acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant or thunder); weapon attacks deal an additional 2d6 damage of that type.'),
  ('spell_storing_level_4_t3',   'Choose a level 4 spell; cast it from the weapon once per short or long rest (+8 attack, DC 16).'),
  ('beacon_t4',                  'Action: plant the weapon for 1 minute. It sheds bright light (30ft); allies within 15ft gain +1 AC and deal +d6 force damage, and allies who can see it may use a bonus action to move half their speed toward it without provoking (once per short or long rest).'),
  ('dancing_t4',                 'Action: the weapon fights on its own for 1 minute. Bonus action to move it up to 20ft and attack; reaction for opportunity attacks from its location (once per short or long rest).'),
  ('mentor_t4',                  'Cast any spell you know, even if not prepared, by expending your highest available spell slot (once per long rest).'),
  ('rallying_t4',                'Action: for 1 minute, allies within 30ft gain advantage on Wis saves and immunity to frightened, and allies moving toward you gain +10ft speed (once per short or long rest).'),
  ('spectral_reach_t4',          'Increase the weapon''s reach by 5ft and deal +d4 damage for 1 minute (once per short or long rest).'),
  ('venomous_t4',                'Creatures damaged by this weapon make a DC 15 Con save or take 2d6 poison damage at the start of each of their turns for 1 minute. A creature that succeeds is immune for 24 hours.'),
  ('will_level_2_t4',            'When you fail a concentration check, you can choose to pass instead (once per long rest).')
) as v(id, effect)
where u.id = v.id;

commit;
