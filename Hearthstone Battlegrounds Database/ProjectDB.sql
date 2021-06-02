-- My Project Database
create table Rarity (
	RarityID int identity,
	Rarity varchar(10) not null,
	constraint pk_rarity primary key (RarityID),
	constraint u1_rarity unique(Rarity)
)

create table Effect (
	EffectID int identity,
	EffectText varchar(500) not null,
	constraint pk_effect primary key (EffectID),
	constraint u1_effect unique(EffectText)
)

create table Tier (
	TierID int identity,
	TierText varchar(5) not null,
	constraint pk_tier primary key (TierID),
	constraint u1_tier unique(TierText)
)

create table Tribe (
	TribeID int identity,
	Tribe varchar(10) not null,
	constraint pk_tribe primary key (TribeID),
	constraint u1_tribe unique(Tribe)
)

create table Keyword (
	KeywordID int identity,
	Keyword varchar(20) not null,
	constraint pk_keyword primary key (KeywordID),
	constraint u1_keyword unique(Keyword)
)

create table EffectKeyword (
	EffectKeywordID int identity,
	EffectID int not null,
	KeywordID int,
	constraint pk_effectkeyword primary key (EffectKeywordID),
	constraint fk1_effectkeyword foreign key (EffectID) references Effect(EffectID),
	constraint fk2_effectkeyword foreign key (KeywordID) references Keyword(KeywordID)
)

create table Minion (
	MinionID int identity,
	Name varchar(30) not null,
	RarityID int not null,
	TierID int not null,
	EffectID int,
	Attack int not null,
	Health int not null,
	TribeID int,
	constraint pk_minion primary key (MinionID),
	constraint fk1_minion foreign key (TierID) references Tier(TierID),
	constraint fk2_minion foreign key (RarityID) references Rarity(RarityID),
	constraint fk3_minion foreign key (EffectID) references Effect(EffectID),
	constraint fk4_minion foreign key (TribeID) references Tribe(TribeID),
	constraint u1_minion unique(name)
)

-- Rarity: Basic, Common, Rare, Epic, Legendary
insert into Rarity(Rarity)
values ('Basic'), ('Common'), ('Rare'), ('Epic'), ('Legendary')

select * from Rarity

-- Tier: 1-6
insert into Tier(TierText)
values ('One'), ('Two'), ('Three'), ('Four'), ('Five'), ('Six')

select * from Tier

-- Tribe: Beast, Demon, Mech, Murloc, none, Pirate, Dragon, All
insert into Tribe(Tribe)
values ('Beast'), ('Demon'), ('Mech'), ('Murloc'), ('Pirate'), ('Dragon'), ('All')

select * from Tribe

-- Keyword: Windfury, Deathrattle, Divine Shield, Battlecry, Taunt, Adapt, Poisonous, Overkill, Immune, Discover, Magnetic, Reborn, Charge
insert into Keyword(Keyword)
values ('Windfury'), ('Deathrattle'), ('Divine Shield'), ('Battlecry'), ('Taunt'), ('Adapt'), ('Poisonous'), ('Overkill'), ('Immune'), ('Discover'), ('Magnetic'), ('Reborn'), ('Charge')

select * from Keyword

--Add effects with a procedure
create procedure addEffect(@effecttext varchar(500))
as begin
	insert into Effect(EffectText)
	values (@effecttext)
	return @@identity
end
go

-- All effects will be copied off each card
DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Summon a 1/1 Cat.'

select * from Effect
-- It works, now we will do this lots of times

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Give this minions Attack to a random friendly minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Reborn	At the end of your turn, give another random friendly minion +1 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever you summon a Murloc, gain +1 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Summon a 1/1 Murloc Scout.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Divine Shield'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Murloc +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever a friendly Beast dies, gain +2/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Give a random friendly minion Divine Shield.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Battlecry: Deal 2 damage to your hero.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Reduce the cost of upgrading Bobs Tavern by (1).'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the start of each turn gain +1 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Start of Combat: Deal 1 damage per friendly Dragon to one random enemy minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a 1/1 Pirate. It attacks immediately.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After you play a Demon, deal 1 damage to your hero and gain +2/+2.'

select * from Effect
-- All tier 1 minions done (16 total)

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a 2/1 Damaged Golem.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Deal 4 damage to a random enemy minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a 3/2 Big Bad Wolf.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your other Mechs +2 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your other Murlocs have +2 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Charge. Has +1 Attack for each other Murloc on the battlefield.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your other Pirates have +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Give your minions +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt. Deathrattle: Deal 1 damage to all minions.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'This minion sells for 3 Gold.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever this attacks double its Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Deathrattle: Summon a 1/1 Imp.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give 3 random friendly minions of different minion types +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Demon +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever you summon a Beast give it +2 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Gain +2/+2 for each other Pogo-Hopper you played this game.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After you play a minion with Deathrattle, gain +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'When you sell this minion give all minions in Bobs Tavern +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever a friendly Dragon kills an enemy, gain +2/+2.'

select * from Effect
-- All tier 2 done (19 minions/35 total)

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your other Murlocs +2 Health.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever you play a card with Battlecry, gain +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your Demons +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your other Murlocs +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Beast +2/+2 and Taunt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever this minion takes damage summon a 1/1 Imp.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon two 1/1 Spiders.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your cards that summon minions summon twice as many.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a number of 1/1 Rats equal to this minions Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Magnetic	Deathrattle: Summon three 1/1 Microbots.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Mech +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a 3/3 Finkle Einhorn for your opponent.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your other Pirates +3 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Divine Shield	Reborn'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Divine Shield	Whenever you summon a Mech during combat, gain +1 Attack and Divine Shield.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the start of your turn, gain +2/+2 if you won the last combat.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After this attacks, trigger a random friendly minions Deathrattle.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a random 2-Cost minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever you play a Pirate, gain +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Each turn this is in your hand, transform it into a random minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After a friendly Demon dies, deal 3 damage to a random enemy minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Battlecry: Give a friendly Dragon +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	After this minion survives being attacked, attack immediately.'

select * from Effect
-- All tier 3 added(23 minions/58 total)

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Magnetic	Divine Shield	Taunt'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Divine Shield	After a friendly minion loses Divine Shield, gain +2 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Also damages the minions next to whomever this attacks.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the end of your turn, give a random friendly minion +3 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give adjacent minions +1/+1 and Taunt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever your hero takes damage on your turn, gain +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the end of your turn, give another friendly Mech +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon an 8/8 Robosaur.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon two 2/2 Hyenas.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever this minion takes damage, summon a 2/3 Mech with Taunt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Your other Demons have +1 Attack.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Murloc Poisonous.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Beast +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After a friendly minion loses Divine Shield, gain +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the end of your turn, gain +2/+2 for each friendly Golden minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Overkill: Deal 3 damage to the left-most enemy minion.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give 3 random friendly minions of different minion types +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: If you control another Murloc, Discover a Murloc.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever another friendly Pirate attacks, give it +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give a friendly Pirate +1/+1 for each Pirate you bought this turn.'

select * from Effect
-- All tier 4 minions added(20 minions/78 total)

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your minions trigger their Deathrattles twice.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your Battlecries trigger twice.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Overkill: Summon a 5/5 Ironhide Runt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever a friendly Mech dies gain +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Your other Demons have +2/+2.	Your hero is Immune.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Give your Taunt minions +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Taunt	Deathrattle: Summon three 1/3 Demons with Taunt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Gain +1 Health for each damage your hero has taken.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After you buy a Pirate, gain 1 Gold this turn only.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry and Deathrattle: Give your other Murlocs +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the end of your turn, give a friendly minion of each type +2/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever you summon a Beast, give it +4/+4.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: Add a random minion from your last opponents warband to your hand.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'When this attacks and kills a minion, add a random minion to your hand.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'At the end of your turn, gain +1/+1 for each Dragon you have.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Windfury	Overkill: Give your other Pirates +2/+2.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon a random Legendary minion.'

select * from Effect
-- All tier 5 done(17 minions/95 total)

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Also damages the minions next to whomever it attacks.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Poisonous'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Battlecry: For each different minion type you have, Adapt randomly'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever a friendly Pirate attacks, give all friendly minions +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon two random Deathrattle minions.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Give your beasts +5/+5.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Whenever this minion takes damage, summon a random Demon and give it Taunt.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'After you play a minion with Battlecry, give your Dragons +1/+1.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon the first 2 friendly Mechs that died the combat.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Give your Dragons Divine Shield.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Deathrattle: Summon 3 random Pirates.'

DECLARE @newEffectID int
EXEC @newEffectID = addEffect 'Windfury	This minion always attacks the enemy minion with the lowest Attack.'

select * from Effect
-- All tier 6 done(12 minions/107 total)
-- No duplicate effects exist

-- Now we can add populate the minion table
create procedure addMinion(@name varchar(30), @rarity int, @tier int, @effect int, @attack int, @health int, @tribe int)
as begin
	insert into Minion(Name, RarityID, TierID, EffectID, Attack, Health, TribeID)
	values (@name, @rarity, @tier, @effect, @attack, @health, @tribe)
	return @@identity
end
go

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Alleycat', 2, 1, 1, 1, 1, 1

select * from Minion
-- It worked

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Fiendish Servant', 2, 1, 2, 2, 1, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Micro Mummy', 4, 1, 3, 1, 2, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Murloc Tidecaller', 3, 1, 4, 1, 2, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Murloc Tidehunter', 1, 1, 5, 2, 1, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Righteous Protector', 2, 1, 6, 1, 1, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Rockpool Hunter', 2, 1, 7, 2, 3, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Scavenging Hyena', 2, 1, 8, 2, 2, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Selfless Hero', 3, 1, 9, 2, 1, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Vulgar Humunculus', 2, 1, 10, 2, 4, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Deck Swabbie', 1, 1, 11, 2, 2, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Dragonspawn Liuetenant', 1, 1, 12, 2, 3, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Micro Machine', 2, 1, 13, 1, 2, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Red Whelp', 1, 1, 14, 1, 2, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Scallywag', 1, 1, 15, 2, 1, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Wrath Weaver', 2, 1, 16, 1, 1, null

select * from Minion
-- All 16 tier 1 minions done

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Harvest Golem', 2, 2, 17, 2, 3, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Kaboom Bot', 2, 2, 18, 2, 2, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Kindly Grandmother', 2, 2, 19, 1, 1, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Metaltooth Leaper', 3, 2, 20, 3, 3, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Murloc Warleader', 4, 2, 21, 3, 3, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Old Murk-Eye', 5, 2, 22, 2, 4, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Southsea Captain', 4, 2, 23, 3, 3, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Spawn of NZoth', 2, 2, 24, 2, 2, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Unstable Ghoul', 2, 2, 25, 1, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Freedealing Gambler', 1, 2, 26, 3, 3, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Glyph Guardian', 1, 2, 27, 2, 4, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Imprisoner', 3, 2, 28, 3, 3, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Menagerie Mug', 1, 2, 29, 2, 2, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Nathrezim Overseer', 3, 2, 30, 2, 3, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Pack Leader', 3, 2, 31, 2, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Pogo-Hopper', 3, 2, 32, 1, 1, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Rabid Saurolisk', 1, 2, 33, 4, 2, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Steward of Time', 1, 2, 34, 3, 4, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Waxrider Togwaggle', 1, 2, 35, 1, 2, null

select * from Minion
-- 35 minions

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Coldlight Seer', 3, 3, 36, 2, 3, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Crowd Favorite', 4, 3, 37, 4, 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Crystalweaver', 1, 3, 38, 5, 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Felfin Navigator', 2, 3, 40, 4, 4, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Houndmaster', 1, 3, 41, 4, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Imp Gang Boss', 2, 3, 42, 2, 4, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Infested Wolf', 3, 3, 43, 3, 3, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Khadgar', 5, 3, 44, 2, 2, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Rat Pack', 4, 3, 45, 2, 2, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Replicating Menace', 3, 3, 46, 3, 1, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Screwjank Clunker', 3, 3, 47, 2, 5, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'The Beast', 5, 3, 48, 9, 7, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Bloodsail Cannoneer', 1, 3, 49, 4, 2, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Bronze Warden', 1, 3, 50, 2, 1, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Deflect-o-Bot', 1, 3, 51, 3, 2, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Hangry Dragon', 1, 3, 52, 4, 4, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Monstrous Macaw', 1, 3, 53, 4, 3, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Piloted Shredder', 2, 3, 54, 4, 3, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Salty Looter', 1, 3, 55, 3, 3, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Shifter Zerus', 5, 3, 56, 1, 1, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Soul Juggler', 1, 3, 57, 3, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Twilight Emissary', 1, 3, 58, 4, 4, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Yo-Ho-Ogre', 1, 3, 59, 2, 8, 5

select * from Minion
-- All tier 3 done

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Annoy-o-Module', 3, 4, 60, 2, 4, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Bolivar, Fireblood', 5, 4, 61, 1, 7, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Cave Hydra', 2, 4, 62, 2, 4, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Cobalt Scalebane', 2, 4, 63, 5, 5, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Defender of Argus', 3, 4, 64, 2, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Floating Watcher', 2, 4, 65, 4, 4, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Iron Sensei', 3, 4, 66, 2, 2, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Mechano-Egg', 2, 4, 67, 0, 5, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Savanna Highmane', 3, 4, 68, 6, 5, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Security Rover', 3, 4, 69, 2, 6, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Siegebreaker', 3, 4, 70, 5, 8, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Toxfin', 2, 4, 71, 1, 2, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Virmen Sensei', 3, 4, 72, 4, 5, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Drakonid Enforcer', 1, 4, 73, 3, 6, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Goldgrubber', 1, 4, 74, 2, 2, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Herald of Flame', 1, 4, 75, 5, 6, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Menagerie Jug', 1, 4, 76, 3, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Primalfin Lookout', 2, 4, 77, 3, 2, 4

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Ripsnarl Captain', 1, 4, 78, 3, 4, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Southsea Strongarm', 1, 4, 79, 5, 4, 5

select * from Minion
-- All tier 4 done, 78 total

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Baron Rivendare', 5, 5, 80, 1, 7, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Brann Bronzebeard', 5, 5, 81, 2, 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Ironhide Direhorn', 2, 5, 82, 7, 7, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Junkbot', 4, 5, 83, 1, 5, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'MalGanis', 5, 5, 84, 9, 7, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Strongshell Scavenger', 3, 5, 85, 2, 3, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Voidlord', 4, 5, 86, 3, 9, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Annihilan Battlemaster', 4, 5, 87, 3, 1, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Capn Hoggar', 1, 5, 88, 6, 6, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'King Bagurgle', 5, 5, 89, 6, 3, 4

-- Found an initial input error
update Effect set EffectText = 'At the end of your turn give a friendly minion of each minion type +2/+1'
where EffectID = 90

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Lightfang Enforcer', 4, 5, 90, 2, 2, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Mama Bear', 4, 5, 91, 4, 4, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Murozond', 1, 5, 92, 5, 5, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Nat Pagle, Extreme Angler', 1, 5, 93, 8, 5, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Razorgore, the Untamed', 1, 5, 94, 2, 4, 6

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Seabreaker Goliath', 1, 5, 95, 6, 7, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Sneeds Old Shredder', 5, 5, 96, 5, 7, 3

select * from Minion

-- All tier 5 completed, 95 total minions

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Foe Reaper 4000', 5, 6, 97, 6, 9, 3

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Maexxna', 5, 6, 98, 2, 8, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Amalgadon', 1, 6, 99, 6, 6, 7

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Dread Admiral Eliza', 1, 6, 100, 6, 7, 5

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Ghastcoiler', 1, 6, 101, 7, 7, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Goldrinn, the Great Wolf', 5, 6, 102, 4, 4, 1

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Imp Mama', 1, 6, 103, 6, 10, 2

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Kalecgos, Arcane Aspect', 1, 6, 104, 4, 12, 6

-- Another input error
update Effect set EffectText = 'Deathrattle: Summon the first 2 friendly Mechs that died this combat.'
where EffectID = 105

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Kangors Apprentice', 4, 6, 105, 3, 6, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Nadina the Red', 1, 6, 106, 7, 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'The Tide Razor', 1, 6, 107, 6, 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addMinion 'Zapp Slywick', 1, 6, 108, 7, 10, null

select * from Minion
-- All 107 minions complete

-- lets look at all the minions with a tribe in a query
select Name, Rarity.Rarity, TierID, Effect.EffectText, Attack, Health, Tribe.Tribe
from Minion
join Rarity on Minion.RarityID = Rarity.RarityID
join Effect on Minion.EffectID = Effect.EffectID
join Tribe on Minion.TribeID = Tribe.TribeID

--Now we will populate the EffectKeyword table

create procedure addEK(@effect int, @keyword int)
as begin
	insert into EffectKeyword(EffectID, KeywordID)
	values (@effect, @keyword)
	return @@identity
end
go

DECLARE @newMinionID int
EXEC @newMinionID = addEK 1, 4

select * from EffectKeyword
-- Works!

DECLARE @newMinionID int
EXEC @newMinionID = addEK 2, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 3, 12

DECLARE @newMinionID int
EXEC @newMinionID = addEK 4, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 5, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 6, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 6, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 7, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 8, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 9, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 9, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 10, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 10, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 11, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 12, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 13, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 14, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 15, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 16, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 17, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 18, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 19, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 20, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 21, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 22, 13

DECLARE @newMinionID int
EXEC @newMinionID = addEK 23, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 24, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 25, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 25, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 26, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 27, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 28, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 28, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 29, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 30, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 31, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 32, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 33, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 34, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 35, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 36, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 37, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 38, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 40, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 41, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 41, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 42, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 43, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 44, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 45, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 46, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 46, 11

DECLARE @newMinionID int
EXEC @newMinionID = addEK 47, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 48, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 49, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 50, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 50, 12

DECLARE @newMinionID int
EXEC @newMinionID = addEK 51, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 52, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 53, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 54, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 55, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 56, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 57, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 58, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 58, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 59, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 60, 11

DECLARE @newMinionID int
EXEC @newMinionID = addEK 60, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 60, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 61, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 62, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 63, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 64, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 64, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 65, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 66, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 67, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 68, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 69, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 70, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 71, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 71, 7

DECLARE @newMinionID int
EXEC @newMinionID = addEK 72, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 73, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 74, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 75, 8

DECLARE @newMinionID int
EXEC @newMinionID = addEK 76, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 77, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 77, 10

DECLARE @newMinionID int
EXEC @newMinionID = addEK 78, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 79, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 80, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 81, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 82, 8

DECLARE @newMinionID int
EXEC @newMinionID = addEK 83, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 84, 9

DECLARE @newMinionID int
EXEC @newMinionID = addEK 85, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 85, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 86, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 86, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 87, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 88, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 89, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 89, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 90, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 91, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 92, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 93, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 94, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 95, 1

DECLARE @newMinionID int
EXEC @newMinionID = addEK 95, 8

DECLARE @newMinionID int
EXEC @newMinionID = addEK 96, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 97, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 98, 7

DECLARE @newMinionID int
EXEC @newMinionID = addEK 99, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 99, 6

DECLARE @newMinionID int
EXEC @newMinionID = addEK 100, null

DECLARE @newMinionID int
EXEC @newMinionID = addEK 101, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 102, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 103, 5

DECLARE @newMinionID int
EXEC @newMinionID = addEK 104, 4

DECLARE @newMinionID int
EXEC @newMinionID = addEK 105, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 106, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 106, 3

DECLARE @newMinionID int
EXEC @newMinionID = addEK 107, 2

DECLARE @newMinionID int
EXEC @newMinionID = addEK 108, 1

select EffectText, Keyword.Keyword
from Effect join EffectKeyword on Effect.EffectID = EffectKeyword.EffectID
join Keyword on EffectKeyword.KeywordID = Keyword.KeywordID

select Name from Minion where TierID = 1

select Name from Minion join Tribe on Minion.TribeID = Tribe.TribeID where Tribe.Tribe = 'Beast'

select Name from Minion join Effect on Minion.EffectID = Effect.EffectID
join EffectKeyword on Effect.EffectID = EffectKeyword.EffectID
join Keyword on EffectKeyword.KeywordID = Keyword.KeywordID
where Keyword.Keyword = 'Battlecry'