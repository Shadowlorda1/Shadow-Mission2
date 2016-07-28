local BaseManager = import('/lua/ai/opai/basemanager.lua')
local SPAIFileName = '/lua/scenarioplatoonai.lua'
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Player = 1
local Aeon = 4


local AeonNbase = BaseManager.CreateBaseManager()

function AeonNavalAI()

  AeonNbase:Initialize(ArmyBrains[Aeon], 'AeonNavalbase', 'AeonNavalMK', 60, {P3Anaval = 100})
     AeonNbase:StartNonZeroBase({9,7})
     AeonNbase:SetActive('AirScouting', true)
     AeonNbase:SetActive('LandScouting', true)
     AeonNbase:SetBuild('Defenses', true)

	 AeonNattacks()
end

function AeonNattacks()

local Temp = {
       'AeonlandTemp1',
       'NoPlan',
       { 'xal0203', 1, 12, 'Attack', 'GrowthFormation' },   --Hover tanks
       { 'ual0205', 1, 4, 'Attack', 'GrowthFormation' },  --moble flak
	   { 'ual0307', 1, 4, 'Attack', 'GrowthFormation' },   --Moble shields
	   }
 local Builder = {
       BuilderName = 'AeonlandBuilder1',
       PlatoonTemplate = Temp,
       InstanceCount = 3,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'AeonNavalbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2Alandattack1'
       },
   }
   ArmyBrains[Aeon]:PBMAddPlatoon( Builder )
   
 Temp = {
       'AeonlandTemp2',
       'NoPlan',
        { 'xal0203', 1, 12, 'Attack', 'GrowthFormation' },  --Hover tanks
       { 'ual0205', 1, 4, 'Attack', 'GrowthFormation' },  --moble flak
	   { 'ual0307', 1, 4, 'Attack', 'GrowthFormation' },  --Moble shields
	   }
  Builder = {
       BuilderName = 'AeonlandBuilder2',
       PlatoonTemplate = Temp,
       InstanceCount = 3,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'AeonNavalbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2Alandattack2'
       },
   }
   ArmyBrains[Aeon]:PBMAddPlatoon( Builder )
   
end