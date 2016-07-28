local BaseManager = import('/lua/ai/opai/basemanager.lua')
local SPAIFileName = '/lua/scenarioplatoonai.lua'
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Player = 1
local UEF = 3


local UEFNbase = BaseManager.CreateBaseManager()
local UEFSbase = BaseManager.CreateBaseManager()
local UEFS2base = BaseManager.CreateBaseManager()

function UEFNbaseAI()
 
  UEFNbase:Initialize(ArmyBrains[UEF], 'NorthUEFbase', 'UEFNbaseMK', 60, {UEFNbase = 100})
    UEFNbase:StartNonZeroBase({8,7})
    UEFNbase:SetActive('AirScouting', true)
    UEFNbase:SetActive('LandScouting', true)
    UEFNbase:SetBuild('Defenses', true)
 
  NorthlandAttacks()
  NorthAirattacks()
 end
 
 function UEFSbaseAI()
 
  UEFSbase:Initialize(ArmyBrains[UEF], 'SouthUEFbase1', 'UEFSBaseMK', 60, {UEFSbase1 = 100})
    UEFSbase:StartNonZeroBase({8,7})
    UEFSbase:SetActive('AirScouting', true)
    UEFSbase:SetActive('LandScouting', true)
    UEFSbase:SetBuild('Defenses', true)
 
 Southlandattacks()
 end
 
 function UEFS2baseAI()
 
  UEFS2base:Initialize(ArmyBrains[UEF], 'SouthUEFbase2', 'UEFS2baseMK', 60, {UEFSbase2 = 100})
    UEFS2base:StartNonZeroBase({8,7})
    UEFS2base:SetActive('AirScouting', true)
    UEFS2base:SetActive('LandScouting', true)
    UEFS2base:SetBuild('Defenses', true)
 
 SouthAirattacks()
 end
 
 function NorthlandAttacks()
 
 local Temp = {
       'LandAttackTemp1',
       'NoPlan',
       { 'xel0305', 1, 3, 'Attack', 'GrowthFormation' },  --heavy bots
       { 'uel0205', 1, 6, 'Attack', 'GrowthFormation' },  --Moblie flak
       { 'uel0307', 1, 3, 'Attack', 'GrowthFormation' },  --Moblesheild
	   }
 local Builder = {
       BuilderName = 'LandAttackBuilder1',
       PlatoonTemplate = Temp,
       InstanceCount = 5,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'NorthUEFbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2Nlandattack1'
       },
   }
   ArmyBrains[UEF]:PBMAddPlatoon( Builder )
 
 end
 
 function  NorthAirattacks()
 
 local Temp = {
       'AirAttackTemp1',
       'NoPlan',
       { 'dea0202', 1, 4, 'Attack', 'GrowthFormation' },  --Fighter/Bombers
       { 'uea0203', 1, 6, 'Attack', 'GrowthFormation' },  --Gunships
	   }
 local Builder = {
       BuilderName = 'AirAttackBuilder1',
       PlatoonTemplate = Temp,
       InstanceCount = 4,
       Priority = 400,
       PlatoonType = 'Air',
       RequiresConstruction = true,
       LocationType = 'NorthUEFbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2Nairattack1'
       },
   }
   ArmyBrains[UEF]:PBMAddPlatoon( Builder )
 
 
 end
 
 function Southlandattacks()
 
  local Temp = {
       'LandAttackTemp2',
       'NoPlan',
       { 'uel0202', 1, 9, 'Attack', 'GrowthFormation' },  --heavy Tanks
       { 'uel0205', 1, 4, 'Attack', 'GrowthFormation' },  --Moblie flak
       { 'uel0307', 1, 3, 'Attack', 'GrowthFormation' },  --Moblesheild
	   }
 local Builder = {
       BuilderName = 'LandAttackBuilder2',
       PlatoonTemplate = Temp,
       InstanceCount = 4,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'SouthUEFbase1',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2S1landattack1'
       },
   }
   ArmyBrains[UEF]:PBMAddPlatoon( Builder )
 
   Temp = {
       'LandAttackTemp3',
       'NoPlan',
       { 'uel0303', 1, 6, 'Attack', 'GrowthFormation' },  --heavy bots
       { 'uel0205', 1, 2, 'Attack', 'GrowthFormation' },  --Moblie flak
       { 'uel0307', 1, 2, 'Attack', 'GrowthFormation' },  --Moblesheild
	   }
  Builder = {
       BuilderName = 'LandAttackBuilder3',
       PlatoonTemplate = Temp,
       InstanceCount = 3,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'SouthUEFbase1',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2S1landattack1'
       },
   }
   ArmyBrains[UEF]:PBMAddPlatoon( Builder )
   
 end
 
 function SouthAirattacks()
 
  local Temp = {
       'AirAttackTemp2',
       'NoPlan',
       { 'uea0305', 1, 4, 'Attack', 'GrowthFormation' },  --ASFs
       { 'uea0203', 1, 12, 'Attack', 'GrowthFormation' },  --Gunships
	   { 'uea0303', 1, 6, 'Attack', 'GrowthFormation' },  --Hev Gunships
	   }
 local Builder = {
       BuilderName = 'AirAttackBuilder2',
       PlatoonTemplate = Temp,
       InstanceCount = 4,
       Priority = 400,
       PlatoonType = 'Air',
       RequiresConstruction = true,
       LocationType = 'SouthUEFbase2',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2S2airattack1'
       },
   }
   ArmyBrains[UEF]:PBMAddPlatoon( Builder )
 
 end