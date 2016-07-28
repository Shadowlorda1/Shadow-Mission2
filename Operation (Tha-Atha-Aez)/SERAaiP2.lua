local BaseManager = import('/lua/ai/opai/basemanager.lua')
local SPAIFileName = '/lua/scenarioplatoonai.lua'
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

local Player = 1
local SeraphimAlly = 2


local Serabase = BaseManager.CreateBaseManager()

function SeraphimBaseAI()

 Serabase:Initialize(ArmyBrains[SeraphimAlly], 'Seraphimbase', 'SeraphimBaseMK', 60, {Gatebase2 = 100})
    Serabase:StartNonZeroBase({9,7})
    Serabase:SetActive('AirScouting', true)
    Serabase:SetActive('LandScouting', true)
    Serabase:SetBuild('Defenses', true)
	
	SeraAirPatrols()
	SeraLandPatrols()

end

function SeraAirPatrols()

 local Temp = {
       'AirDefenceTemp1',
       'NoPlan',
       { 'xsa0202', 1, 8, 'Attack', 'GrowthFormation' },  --Fighter/bombers
       { 'xsa0203', 1, 12, 'Attack', 'GrowthFormation' },  --Gunships
	   { 'xsa0303', 1, 6, 'Attack', 'GrowthFormation' },  --ASFs
	   }
 local Builder = {
       BuilderName = 'AirDefenceBuilder1',
       PlatoonTemplate = Temp,
       InstanceCount = 3,
       Priority = 400,
       PlatoonType = 'Air',
       RequiresConstruction = true,
       LocationType = 'Seraphimbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2SeraDchain1'
       },
   }
   ArmyBrains[SeraphimAlly]:PBMAddPlatoon( Builder )

end

function SeraLandPatrols()

 local Temp = {
       'landDefenceTemp1',
       'NoPlan',
       { 'xsl0202', 1, 8, 'Attack', 'GrowthFormation' },  --Assault bots
       { 'xsl0205', 1, 4, 'Attack', 'GrowthFormation' },  --moble Flak
	   { 'xsl0303', 1, 4, 'Attack', 'GrowthFormation' },  --Seige Tanks
	   }
 local Builder = {
       BuilderName = 'landDefenceBuilder1',
       PlatoonTemplate = Temp,
       InstanceCount = 3,
       Priority = 400,
       PlatoonType = 'Land',
       RequiresConstruction = true,
       LocationType = 'Seraphimbase',
       PlatoonAIFunction = {SPAIFileName, 'PatrolThread'},     
       PlatoonData = {
           PatrolChain = 'P2SeraDchain2'
       },
   }
   ArmyBrains[SeraphimAlly]:PBMAddPlatoon( Builder )

end