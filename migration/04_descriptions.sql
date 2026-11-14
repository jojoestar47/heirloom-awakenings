-- Heirloom Awakenings — rewrite every awakening in the "tags + short bullets" style.
-- Generated from 04_descriptions.json by build_04.mjs; edit the JSON, not this file.
--
-- effect: short lines, "- " starts a bullet, **text** is bold (rendered by index.html).
-- tags:   when/how it's used (Action, Reaction, 1 minute, Short or long rest, ...).

begin;

alter table public.ha_upgrades add column if not exists tags text[] not null default '{}';

update public.ha_upgrades as u set tags = v.tags, effect = v.effect
from (values
  ('duelist_level_1_t1', array['Reaction']::text[], 'When a melee attack you can see hits you, add **+1 AC** against that attack. This can turn the hit into a miss.'),
  ('enhanced_weapon_level_1_t1', array['Passive']::text[], '**+1** to attack and damage rolls with this heirloom.'),
  ('infusion_level_1_t1', array['Passive']::text[], 'Pick a damage type when you take this: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant or thunder.
- Every hit with this heirloom deals **+1d6** damage of that type.'),
  ('magical_core_level_1_t1', array['Action','2 per long rest']::text[], 'Pick a cantrip when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+4**, save **DC 12**.'),
  ('magus_level_1_t1', array['Passive']::text[], 'While you hold this heirloom:
- **+1** to spell attack rolls
- **+1 AC**'),
  ('slayer_level_1_t1', array['Passive']::text[], 'Pick a creature type when you take this: beasts, fey, humanoids, monstrosities or undead.
- Every hit with this heirloom deals **+2d6** damage to that type.'),
  ('spell_link_level_1_t1', array['Long rest']::text[], 'You gain one extra **1st-level spell slot**. It comes back when you finish a long rest.'),
  ('spell_storing_level_1_t1', array['Action','Long rest']::text[], 'Pick a 1st-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+4**, save **DC 12**.'),
  ('spell_storing_level_2_t1', array['Action','Long rest']::text[], 'Pick a 2nd-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+4**, save **DC 12**.'),
  ('bully_t1', array['Passive']::text[], 'Advantage on **Charisma (Intimidation)** checks while you hold this heirloom and the target can see you.'),
  ('charmward_t1', array['Passive']::text[], 'Advantage on saving throws against being **charmed**.'),
  ('darkvision_t1', array['Passive']::text[], 'You gain **darkvision 60 ft**. If you already have darkvision, its range increases by 60 ft.'),
  ('deathward_t1', array['Passive']::text[], 'Advantage on **death saving throws**.'),
  ('fearward_t1', array['Passive']::text[], 'Advantage on saving throws against being **frightened**.'),
  ('focus_t1', array['Passive']::text[], 'You can use this heirloom as a **spellcasting focus**.'),
  ('giant_bane_t1', array['Passive']::text[], 'Hits with this heirloom deal **+1d6** damage to Large or bigger creatures.'),
  ('gripped_t1', array['Passive']::text[], 'Nothing can make you **drop this heirloom** against your will.'),
  ('guiding_t1', array['Passive']::text[], 'The heirloom sheds **bright light 15 ft** and dim light for another 15 ft, in a color you pick when you take this.'),
  ('hidden_t1', array['Action','Until you end it']::text[], 'Speak the command word to disguise the heirloom as a different item of a similar size. Speak it again to end the disguise.
- The heirloom keeps all its abilities.
- A creature that uses its action to examine it sees through the illusion with a **DC 12 Intelligence (Investigation)** check.'),
  ('hinge_bane_t1', array['Passive']::text[], 'Hits with this heirloom deal **maximum damage** to objects like doors, chests and locks.'),
  ('indomitable_level_1_t1', array['When you drop to 0 HP']::text[], 'Before you fall unconscious, make **one attack** with this heirloom. This doesn''t use your reaction.'),
  ('jarring_level_1_t1', array['Passive']::text[], 'A creature you damage with this heirloom **can''t make opportunity attacks** against you until the start of your next turn.'),
  ('marksman_t1', array['Passive']::text[], 'No ammunition needed. When you ready the heirloom, a spectral arrow or bolt appears that counts as **magical ammunition**.'),
  ('overpower_brawler_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Strength** save or is knocked **prone**.'),
  ('overpower_brutish_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Strength** save or you **push it 10 ft** in a direction you choose.'),
  ('overpower_disarming_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Strength** save or **drops one item** of your choice that it''s holding.
- It has advantage on the save if it holds that item with two or more hands.'),
  ('overpower_dread_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Wisdom** save or is **frightened** of you for 1 minute.
- It repeats the save at the end of each of its turns, ending the effect on a success.'),
  ('overpower_hamstring_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Dexterity** save or its **speed is halved** until the start of your next turn.'),
  ('overpower_poisonous_t1', array['On a hit with a 19 or 20']::text[], 'The target makes a **DC 14 Constitution** save or is **poisoned**.
- It repeats the save at the end of each of its turns, ending the effect on a success.'),
  ('poisonward_t1', array['Passive']::text[], 'Advantage on saving throws against being **poisoned**.'),
  ('proficient_level_1_t1', array['Passive']::text[], 'Gain proficiency in **1 skill** of your choice.'),
  ('quick_t1', array['Passive']::text[], 'Advantage on **initiative** rolls.'),
  ('ritualist_t1', array['Passive']::text[], 'Casting a spell as a **ritual** takes half the usual time while the heirloom is on you.'),
  ('shadowed_t1', array['Passive']::text[], 'Cover you''re behind counts as one step better: **half cover counts as three-quarters**.'),
  ('unflinching_t1', array['Passive']::text[], 'Being within 5 ft of an enemy **doesn''t give you disadvantage** on ranged attack rolls.'),
  ('willing_t1', array['Long rest']::text[], 'Add **1d4** to one ability check. You can decide after you roll, but before the DM says whether it worked.'),
  ('amplify_level_1_t2', array['Passive']::text[], '**+1** to one ability score of your choice, to a maximum of 20.'),
  ('duelist_level_2_t2', array['Reaction']::text[], 'When a melee attack you can see hits you, add **+2 AC** against that attack. This can turn the hit into a miss.'),
  ('enhanced_weapon_level_2_t2', array['Passive']::text[], '**+2** to attack and damage rolls with this heirloom.'),
  ('guardian_level_1_t2', array['Passive']::text[], 'Gain proficiency in **1 saving throw** of your choice.'),
  ('keen_level_1_t2', array['Passive']::text[], 'This heirloom scores a **critical hit on a 19 or 20**.'),
  ('magical_core_level_2_t2', array['Action','At will']::text[], 'Pick a cantrip when you take this.
- Cast it from the heirloom as an action, as often as you like.
- Spell attack **+4**, save **DC 14**.'),
  ('spell_link_level_2_t2', array['Long rest']::text[], 'You gain one extra **2nd-level spell slot**. It comes back when you finish a long rest.'),
  ('spell_storing_level_3_t2', array['Action','Long rest']::text[], 'Pick a 3rd-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+6**, save **DC 14**.'),
  ('stern_t2', array['Start of your turn','Until your next turn']::text[], 'Plant your feet until the start of your next turn:
- **+2 AC**
- Your speed is **0**
- You **can''t take reactions**'),
  ('barbaric_t2', array['Passive']::text[], 'When you drop a creature to 0 HP with this heirloom, you have **advantage on your next attack**.'),
  ('battlemage_t2', array['Bonus action']::text[], 'When you cast a spell, you can make **one attack** with this heirloom as a bonus action.'),
  ('blindside_level_1_t2', array['Passive']::text[], 'Your **Sneak Attack** with this heirloom deals **+1d6** damage.'),
  ('bolstering_t2', array['Passive']::text[], 'When a spell heals you, regain extra HP equal to your **Constitution modifier**.'),
  ('challenge_t2', array['Passive']::text[], 'When you use **Reckless Attack**, pick one creature you can see. It doesn''t get advantage against you from Reckless Attack until the start of your next turn.'),
  ('charged_smite_level_1_t2', array['Passive']::text[], 'Your **Divine Smite** deals **+1d8 radiant** damage.'),
  ('distracting_level_1_t2', array['Action']::text[], 'Make one attack with this heirloom, then **move up to half your speed** without provoking opportunity attacks.
- This is its own action, not the Attack action, so Extra Attack doesn''t apply.'),
  ('divine_grace_t2', array['10 minutes','Short or long rest']::text[], 'Spend 10 minutes communing with your deity. In the next 24 hours, you can **reroll any one die** and keep the new roll.
- After you use the reroll, finish a short or long rest before you can commune again.'),
  ('divine_touch_t2', array['Passive']::text[], 'The first time each turn you deal melee damage with this heirloom, one ally within 5 ft of you **regains 1d4 HP**.'),
  ('doomerang_t2', array['Passive']::text[], 'The heirloom gains the **thrown** property (range 20/60 ft) and flies back to your hand at the end of your turn.
- Each creature in its path back makes a **DC 10 Dexterity** save or takes **1d6** damage of the type your heirloom deals.'),
  ('en_guard_t2', array['Reaction','Short or long rest']::text[], 'When you or an ally within 5 ft of you is targeted by an attack you can see, pick one:
- The target gets **+5 AC** against that attack
- After the attack, **move up to your speed** without provoking opportunity attacks
- Make a **melee attack** against the attacker
- Gain **advantage** against the attacker until the end of your next turn'),
  ('eye_of_the_storm_t2', array['Action','Long rest']::text[], 'Regain **ki (Focus) points** equal to half your monk level, rounded down.'),
  ('guard_t2', array['Reaction']::text[], 'When a weapon attack you can see targets an ally within 5 ft of you, give that attack **disadvantage**.'),
  ('hunter_s_watch_t2', array['Reaction','Short or long rest']::text[], 'When a creature moves within 30 ft of you, make an **opportunity attack** against it.
- On a hit, it makes a **DC 14 Dexterity** save or its **speed drops to 0** until the end of its turn.'),
  ('jarring_level_2_t2', array['Passive']::text[], 'A creature you **attack** with this heirloom, hit or miss, can''t make opportunity attacks against you until the start of your next turn.'),
  ('mobile_level_1_t2', array['Passive']::text[], '**+5 ft** to your speed.'),
  ('piercing_level_1_t2', array['Passive']::text[], '**+2** to attack rolls against creatures using a shield.'),
  ('power_of_the_ancestors_t2', array['Once per day']::text[], 'When you spend **sorcery points**, you can choose not to spend them.'),
  ('precise_level_1_t2', array['Passive']::text[], 'When you roll a **1** on a damage die for this heirloom, reroll it. You must keep the new roll.'),
  ('proficient_level_2_t2', array['Passive']::text[], 'Gain proficiency in **2 skills** of your choice.'),
  ('quickshot_t2', array['Passive']::text[], 'The first time you hit on your turn, you have **advantage on your next attack** with this heirloom that turn.'),
  ('rampaging_t2', array['Passive']::text[], '**Advantage** on attacks with this heirloom against a target that was more than 20 ft away when your turn started.'),
  ('reckless_t2', array['Passive']::text[], 'When you have advantage on an attack with this heirloom, you can **reroll the damage dice**. You must keep the new roll.'),
  ('reverberation_t2', array['When you attack']::text[], 'When you attack with this heirloom, you can spend one **Bardic Inspiration**.
- If the attack deals damage, the target makes a **Wisdom** save against your spell save DC.
- On a failure, it''s **charmed** or **frightened** by you (your choice) for 1 minute. It repeats the save at the end of each of its turns.'),
  ('scout_t2', array['Passive']::text[], '**Advantage** on attacks with this heirloom during the first round of combat.'),
  ('sniping_t2', array['Passive']::text[], 'Your target''s cover counts as one step worse: **three-quarters counts as half**, and **half counts as none**.'),
  ('spellhunter_t2', array['Passive']::text[], 'Hits with this heirloom deal **+2d6 psychic** damage to creatures that can cast spells.'),
  ('sprightly_t2', array['Bonus action']::text[], 'Gain **advantage** on your next attack roll.
- If that attack hits, you can''t use this again until you finish a short or long rest. If it misses, you can use it again.'),
  ('telepathic_link_t2', array['Passive']::text[], 'Speak **telepathically** with any creature you know that you can see within 60 ft.'),
  ('transforming_t2', array['Action']::text[], 'Turn the heirloom into a plain, **nonmagical** version of itself. It loses all its abilities, and detect magic can''t sense it.
- Speak its command word as an action to restore it.'),
  ('transposed_t2', array['Bonus action']::text[], 'Send the heirloom to a pocket dimension, or **summon it** back to your hand.'),
  ('trapped_spell_t2', array['Bonus action','Long rest']::text[], 'When you finish a long rest, store one spell you know in the heirloom.
- Release it as a **bonus action**.
- No spell slot needed, and no verbal or somatic components.'),
  ('underhanded_t2', array['Reaction']::text[], 'When a melee attack targets you or an ally within 5 ft of you, give it **disadvantage**.
- If the attack misses, you can''t use this again until you finish a short or long rest.'),
  ('vicious_level_1_t2', array['Passive']::text[], 'Critical hits on a natural 20 with this heirloom deal **+2d6** damage of the same type.'),
  ('wild_spell_t2', array['Wild Shape']::text[], 'When you use Wild Shape, you can spend a spell slot to ready a spell of that level.
- Once during that Wild Shape, cast it as an **action**.'),
  ('will_of_the_ancestors_t2', array['Action','Short or long rest']::text[], 'Each enemy within 15 ft of you makes a **DC 14 Wisdom** save.
- Fail: **2d8 psychic** damage
- Success: half damage'),
  ('duelist_level_3_t3', array['Reaction']::text[], 'When a melee attack you can see hits you, add **+3 AC** against that attack. This can turn the hit into a miss.'),
  ('enhanced_weapon_level_3_t3', array['Passive']::text[], '**+3** to attack and damage rolls with this heirloom.'),
  ('flying_t3', array['Passive']::text[], 'You gain a **flying speed** equal to your walking speed.'),
  ('infusion_level_2_t3', array['Passive']::text[], 'Pick a damage type when you take this: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant or thunder.
- Every hit with this heirloom deals **+2d6** damage of that type.'),
  ('magical_core_level_3_t3', array['Action','2 per long rest']::text[], 'Pick a 1st-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+8**, save **DC 16**.'),
  ('magus_level_2_t3', array['Passive']::text[], 'While you hold this heirloom:
- **+2** to spell attack rolls
- **+2 AC**'),
  ('spell_link_level_3_t3', array['Long rest']::text[], 'You gain one extra **3rd-level spell slot**. It comes back when you finish a long rest.'),
  ('spell_storing_level_4_t3', array['Action','Short or long rest']::text[], 'Pick a 4th-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+8**, save **DC 16**.'),
  ('blindside_level_2_t3', array['Passive']::text[], 'Your **Sneak Attack** with this heirloom deals **+2d6** damage.'),
  ('blood_drinker_level_1_t3', array['On a hit with a 19 or 20']::text[], 'Gain **temporary HP** equal to half the damage this heirloom dealt, rounded down.'),
  ('brawn_t3', array['Passive']::text[], 'You **can''t be knocked prone**, and you have advantage on checks to **grapple**.'),
  ('charged_smite_level_2_t3', array['Passive']::text[], 'Your **Divine Smite** deals **+2d8 radiant** damage.'),
  ('distracting_level_2_t3', array['Action']::text[], '**Move up to half your speed** without provoking opportunity attacks, then make one attack with this heirloom.
- This is its own action, not the Attack action, so Extra Attack doesn''t apply.'),
  ('elemental_manipulation_t3', array['Passive']::text[], 'When you cast a spell using a spell slot, you can **change one of its damage types**.
- Swap between acid, cold, fire, force, lightning, necrotic, radiant and thunder.'),
  ('elemental_resistance_t3', array['Passive']::text[], 'Pick a damage type when you take this: fire, cold, lightning, radiant, thunder, necrotic, force, psychic or poison.
- You have **resistance** to it.'),
  ('focused_t3', array['Passive']::text[], 'Pick an ability when you take this.
- A creature you damage with this heirloom has **disadvantage on saves** with that ability until the start of your next turn.'),
  ('hardy_t3', array['Action','Long rest']::text[], 'Spend up to **half your Hit Dice** to heal. Roll them and add your Constitution modifier to each, like on a short rest.'),
  ('indomitable_level_2_t3', array['When you drop to 0 HP']::text[], 'Before you fall unconscious, take the **Attack action** with this heirloom, including Extra Attack.'),
  ('lashing_t3', array['Passive']::text[], 'When you make an opportunity attack, make **one extra attack** with this heirloom. Don''t add your ability modifier to its damage.'),
  ('nemesis_t3', array['10 minutes']::text[], 'Spend 10 minutes focusing on a creature you know to make it your **nemesis**.
- Hits with this heirloom deal **+2d8 psychic** damage to it.
- You can''t pick a new nemesis for **1 week**, even if it dies.'),
  ('proficient_level_3_t3', array['Passive']::text[], 'Gain proficiency in **3 skills** of your choice.'),
  ('rapid_strike_t3', array['Bonus action']::text[], 'When you attack with this heirloom, make **one extra attack** against a different creature in range.
- Don''t add your ability modifier to its damage.
- Costs **6 SP** if your heirloom is a ranged weapon (4 SP otherwise).'),
  ('shimmering_t3', array['Passive']::text[], 'While you''re within 5 ft of another creature, **ranged attacks against you have disadvantage**.'),
  ('spelleater_t3', array['Reaction']::text[], 'When a creature within 5 ft of you casts a spell, make an **opportunity attack** against it.'),
  ('spellhunter_t3', array['Passive']::text[], 'Concentration saves caused by this heirloom''s damage are made with **disadvantage**.'),
  ('sustaining_t3', array['Passive']::text[], 'While you carry this heirloom, you don''t need to **eat, drink or sleep**.'),
  ('tracking_t3', array['Action']::text[], 'Learn the exact **direction** of a creature this heirloom damaged in the last week, as long as it''s within 10 miles.'),
  ('will_level_1_t3', array['Long rest']::text[], 'When you fail a **concentration** save, reroll it.'),
  ('amplify_level_2_t4', array['Passive']::text[], '**+2** to one ability score of your choice, to a maximum of 20.'),
  ('guardian_level_2_t4', array['Passive']::text[], 'Gain proficiency in **1 saving throw** of your choice.
- You also have **advantage** on those saves when you can see the source of the effect.'),
  ('keen_level_2_t4', array['Passive']::text[], 'This heirloom scores a **critical hit on an 18, 19 or 20**.'),
  ('magical_core_level_4_t4', array['Action','At will']::text[], 'Pick a 1st-level spell when you take this.
- Cast it from the heirloom as an action, as often as you like.
- Spell attack **+8**, save **DC 16**.'),
  ('slayer_level_2_t4', array['Passive']::text[], 'Pick a creature type when you take this: beasts, fey, humanoids, monstrosities or undead.
- Every hit with this heirloom deals **+4d6** damage to that type.'),
  ('spell_link_level_4_t4', array['Long rest']::text[], 'You gain one extra **4th-level spell slot**. It comes back when you finish a long rest.'),
  ('spell_storing_level_5_t4', array['Action','Long rest']::text[], 'Pick a 5th-level spell when you take this.
- Cast it from the heirloom as an action.
- Spell attack **+8**, save **DC 16**.'),
  ('truesight_t4', array['Passive']::text[], 'While you hold this heirloom, you have **truesight 60 ft**.'),
  ('beacon_t4', array['Action','1 minute','Short or long rest']::text[], 'Plant your heirloom in the ground. While it stays planted:
- It sheds **bright light 30 ft** and dim light for another 30 ft.
- You and allies within 15 ft of it get **+1 AC** and deal **+1d6 force** damage on weapon hits.
- Allies who can see it can use a **bonus action** to move up to half their speed toward it, without provoking opportunity attacks.
- Pulling it out ends the effect.'),
  ('blood_drinker_level_2_t4', array['On a hit with a 19 or 20']::text[], 'Gain **temporary HP** equal to the damage this heirloom dealt.'),
  ('dancing_t4', array['Action','1 minute','Short or long rest']::text[], 'Speak the command word and the heirloom floats and fights on its own.
- **Bonus action:** move it up to 20 ft and attack with it as if you were holding it.
- **Reaction:** it makes an opportunity attack from where it is.'),
  ('homing_t4', array['Passive']::text[], 'You can attack creatures in range even **without line of sight**.
- These attacks have **disadvantage**.
- The target counts as having **three-quarters cover**.'),
  ('mentor_t4', array['Long rest']::text[], 'Cast any spell you know, even one you haven''t prepared, by spending your **highest-level** available spell slot.'),
  ('mobile_level_2_t4', array['Passive']::text[], '**+10 ft** to your speed.'),
  ('piercing_level_2_t4', array['Passive']::text[], '**+4** to attack rolls against creatures using a shield.'),
  ('power_surge_t4', array['Once per day']::text[], 'Cast a spell you know at up to **2 levels higher** than the spell slot you spend.'),
  ('precise_level_2_t4', array['Passive']::text[], 'You can **reroll** this heirloom''s damage roll. You must keep the new roll.'),
  ('proficient_level_4_t4', array['Passive']::text[], 'Gain proficiency in **4 skills** of your choice.'),
  ('protective_t4', array['Short or long rest']::text[], 'Make one saving throw with **advantage**. Decide before you roll.'),
  ('rallying_t4', array['Action','1 minute','Short or long rest']::text[], 'Raise the heirloom and let out a war cry. For 1 minute, allies within 30 ft of you:
- Have **advantage on Wisdom saves**
- Are **immune to frightened**
- Get **+10 ft speed** while moving straight toward you'),
  ('spectral_reach_t4', array['Bonus action','1 minute','Short or long rest']::text[], 'For 1 minute:
- This heirloom''s reach increases by **5 ft**
- Hits with it deal **+1d4** damage'),
  ('venomous_t4', array['Passive']::text[], 'A creature you damage with this heirloom makes a **DC 15 Constitution** save.
- Fail: it takes **2d6 poison** damage at the start of each of its turns for 1 minute.
- Success: it''s immune to this effect for 24 hours.'),
  ('vicious_level_2_t4', array['Passive']::text[], 'Critical hits on a natural 20 with this heirloom deal **+4d6** damage of the same type.'),
  ('whirlwind_t4', array['Action']::text[], 'Make a **melee attack** against every creature within 5 ft of you.'),
  ('will_level_2_t4', array['Long rest']::text[], 'When you fail a **concentration** save, you can succeed instead.')
) as v(id, tags, effect)
where u.id = v.id;

-- Heirlooms in this campaign aren't always weapons.
update public.ha_upgrades set name = replace(name, 'Enhanced Weapon', 'Enhanced Heirloom')
where name like 'Enhanced Weapon%';

commit;
