local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua') 
local Objectives = import('/lua/ScenarioFramework.lua').Objectives
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local ScenarioPlatoonAI = import('/lua/ScenarioPlatoonAI.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local Utilities = import('/lua/Utilities.lua')
local Cinematics = import('/lua/cinematics.lua')
local P2UEFAI = import('/maps/Operation (Tha-Atha-Aez)/UEFaiP2.lua')
local P2SERAAI = import('/maps/Operation (Tha-Atha-Aez)/SERAaiP2.lua')
local P2AEONAI = import('/maps/Operation (Tha-Atha-Aez)/AEONaiP2.lua')

ScenarioInfo.Player = 1
ScenarioInfo.SeraphimAlly = 2
ScenarioInfo.UEF = 3
ScenarioInfo.Aeon = 4
ScenarioInfo.Cybran = 5
ScenarioInfo.HumanPlayers = {ScenarioInfo.Player}

local Player = ScenarioInfo.Player
local SeraphimAlly = ScenarioInfo.SeraphimAlly
local Aeon = ScenarioInfo.Aeon
local UEF = ScenarioInfo.UEF
local Cybran = ScenarioInfo.Cybran

local timeAttackP2 = 480

local SkipNIS2 = true

function OnPopulate() 
    ScenarioUtils.InitializeScenarioArmies()
   
   
   ScenarioFramework.SetSeraphimColor(Player)
    ScenarioFramework.SetUEFPlayerColor(UEF)
	 ScenarioFramework.SetNeutralColor (SeraphimAlly)
	 
	ScenarioUtils.CreateArmyGroup('Player', 'Pintbase', false)
	ScenarioUtils.CreateArmyGroup('Player', 'Pintbasewreak', true)
	ScenarioUtils.CreateArmyGroup('SeraphimAlly', 'Gatebase1', false)
	
	 local units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P1attack1', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P1intattack1')
    end
	
	  units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P1attack2', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P1intattack2')
    end
	
	  units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P1attack3', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P1intattack3')
    end
	
	  units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P1attack4', 'AttackFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P1intattack4')
    end
	
end 

function OnStart(self) 

 Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('Commanderwarp'), 0)
 
 ForkThread(IntroPart1)
end

function IntroPart1()
 ScenarioFramework.SetPlayableArea('AREA_1', false)
 
  Cinematics.EnterNISMode()
  
  ScenarioInfo.PlayerCDR = ScenarioUtils.CreateArmyUnit('Player', 'Commander')
    ScenarioFramework.FakeGateInUnit(ScenarioInfo.PlayerCDR)
	
	  local cmd = IssueMove({ScenarioInfo.PlayerCDR}, ScenarioUtils.MarkerToPosition('ComMove'))
 
WaitSeconds(2)
Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('Pintattackcam1'), 2)
WaitSeconds(1)
Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('Pintattackcam2'), 2)
WaitSeconds(1)
Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('Pintattackcam3'), 2)
WaitSeconds(1)

 Cinematics.ExitNISMode()
   
   StartPart1()
 end
 
 function StartPart1()
 
    # --------------------------------------------
    # Primary Objective 1 - Survive UEF assault
    # --------------------------------------------
    ScenarioInfo.M1P1 = Objectives.CategoriesInArea(
        'primary',                      # type
        'incomplete',                   # complete
        'Survive UEF Assault',                 # title
        'Kill all UEF forces attacking you.',  # description
        'kill',                         # action
        {                               # target
            MarkUnits = true,
			ShowProgress = true,
            Requirements = {
                {   
                    Area = 'AREA_1',
                    Category = categories.UEF,
                    CompareOp = '<=',
                    Value = 0,
                    ArmyIndex = UEF,
                },
                
            },
        }
   )
    ScenarioInfo.M1P1:AddResultCallback(
    function(result)
        if(result) then
		 
            IntroPart2()
        end
    end
)
 
    ----------------------------------------------
    -- Primary Objective 2 - The Gate Must Survive
    ----------------------------------------------
    ScenarioInfo.M1P1 = Objectives.Protect(
        'primary',                      -- type
        'incomplete',                   -- complete
        'The Gate Must Survive',                -- title
        'Without The Gate the Retreat is over.', -- description
       
        {                              -- target
		  MarkUnits = true,
             Units = {ScenarioInfo.Gate},
        }
   )
    ScenarioInfo.M1P1:AddResultCallback(
    function(result)
        if(result) then
		 
           
        end
    end
)
 
 end
 
 function IntroPart2()
 
   if not SkipNIS2 then
   
  ScenarioInfo.M1P1 = Objectives.Timer(
        'primary',                      # type
        'incomplete',                   # complete
        'Prepare For Second UEF Assault',                 # title
        'Rebuild Your Defences. Expect the Next Wave To Be Much Stronger',  # description
                              
        {                               # target
           Timer = timeAttackP2,
		   ExpireResult = 'complete',
		   }
		  )

	   ScenarioInfo.M1P1:AddResultCallback(
    function(result)
        if(result) then
		
		 StartMission2()
          
        end
    end
   )
   
else

StartMission2()
	
 end
 end
 
function StartMission2()

ScenarioUtils.CreateArmyGroup('UEF', 'UEFForwardefences')

 local units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P2attack1', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P2intattack1')
    end
	
	  units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P2attack2', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P2intattack2')
    end
	
	  units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'P2attack3', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P2intattack3')
    end

	   # --------------------------------------------
    # Primary Objective 3 - Survive Second UEF assault
    # --------------------------------------------
    ScenarioInfo.M1P1 = Objectives.CategoriesInArea(
        'primary',                      # type
        'incomplete',                   # complete
        'Survive Second UEF Assault',                 # title
        'Kill all UEF forces attacking you.',  # description
        'kill',                         # action
        {                               # target
            MarkUnits = true,
			ShowProgress = true,
            Requirements = {
                {   
                    Area = 'AREA_2',
                    Category = categories.MOBILE,
                    CompareOp = '<=',
                    Value = 0,
                    ArmyIndex = UEF,
                },
                
            },
        }
   )
    ScenarioInfo.M1P1:AddResultCallback(
    function(result)
        if(result) then
		 
            Start2Mission2()
        end
    end
)
 
 
end

function Start2Mission2 ()
 ScenarioFramework.SetPlayableArea('AREA_2', true)

P2SERAAI.SeraphimBaseAI()
P2AEONAI.AeonNavalAI()
P2UEFAI.UEFNbaseAI()
P2UEFAI.UEFSbaseAI()
P2UEFAI.UEFS2baseAI()

local units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'SbaseD1', 'AttackFormation')
   for k, v in units:GetPlatoonUnits() do
       ScenarioFramework.GroupPatrolRoute({v}, ScenarioPlatoonAI.GetRandomPatrolRoute(ScenarioUtils.ChainToPositions('P2SbaseDchain')))
   end

   units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'SbaseD2', 'AttackFormation')
   for k, v in units:GetPlatoonUnits() do
       ScenarioFramework.GroupPatrolRoute({v}, ScenarioPlatoonAI.GetRandomPatrolRoute(ScenarioUtils.ChainToPositions('P2S2baseDchain')))
   end
   
   units = ScenarioUtils.CreateArmyGroupAsPlatoon('UEF', 'NbaseD', 'AttackFormation')
   for k, v in units:GetPlatoonUnits() do
       ScenarioFramework.GroupPatrolRoute({v}, ScenarioPlatoonAI.GetRandomPatrolRoute(ScenarioUtils.ChainToPositions('P2NbaseDchain')))
   end
   
    units = ScenarioUtils.CreateArmyGroupAsPlatoon('SeraphimAlly', 'SApatrolG1', 'AttackFormation')
   for k, v in units:GetPlatoonUnits() do
       ScenarioFramework.GroupPatrolRoute({v}, ScenarioPlatoonAI.GetRandomPatrolRoute(ScenarioUtils.ChainToPositions('P2SeraDchain2')))
   end
   
    units = ScenarioUtils.CreateArmyGroupAsPlatoon('SeraphimAlly', 'SApatrolG2', 'AttackFormation')
   for k, v in units:GetPlatoonUnits() do
       ScenarioFramework.GroupPatrolRoute({v}, ScenarioPlatoonAI.GetRandomPatrolRoute(ScenarioUtils.ChainToPositions('P2SeraDchain1')))
   end
   
     units = ScenarioUtils.CreateArmyGroupAsPlatoon('Aeon', 'AP2attack1', 'GrowthFormation')
    for k, v in units:GetPlatoonUnits() do
        ScenarioFramework.GroupPatrolChain({v}, 'P2Aintattack1')
    end
   
   Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('Commanderwarp'), 0)
   
   Cinematics.EnterNISMode()
   
   local VisMarker2_1 = ScenarioFramework.CreateVisibleAreaLocation(50, ScenarioUtils.MarkerToPosition('CaminfoP2_3'), 0, ArmyBrains[Player])
   local VisMarker2_2 = ScenarioFramework.CreateVisibleAreaLocation(50, ScenarioUtils.MarkerToPosition('CamnfoP2_1'), 0, ArmyBrains[Player])
   local VisMarker2_3 = ScenarioFramework.CreateVisibleAreaLocation(50, ScenarioUtils.MarkerToPosition('CamnfoP2_2'), 0, ArmyBrains[Player])
   
   Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('CamP2_1'), 3)
   WaitSeconds(1)
   Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('CamP2_2'), 3)
   WaitSeconds(1)
   Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('CamP2_3'), 3)
   WaitSeconds(1)
  Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('CamP2_4'), 3)
  WaitSeconds(1)
  Cinematics.CameraMoveToMarker(ScenarioUtils.GetMarker('CamP2_5'), 3)
  
   ForkThread(
            function()
                WaitSeconds(2)
                VisMarker2_1:Destroy()
                VisMarker2_2:Destroy()
                VisMarker2_3:Destroy()
                WaitSeconds(2)
				end
				)
  
   Cinematics.ExitNISMode()
   
   	   # --------------------------------------------
    # Primary Objective 4 - Survive Second UEF assault
    # --------------------------------------------
    ScenarioInfo.M1P1 = Objectives.CategoriesInArea(
        'primary',                      # type
        'incomplete',                   # complete
        'Go On the Offensive ',                 # title
        'Destroy all UEF Forces In The Area .',  # description
        'kill',                         # action
        {                               # target
            MarkUnits = true,
			ShowProgress = true,
            Requirements = {
                {   
                    Area = 'P2NbaseArea',
                    Category = categories.FACTORY,
                    CompareOp = '<=',
                    Value = 0,
                    ArmyIndex = UEF,
                },
                {   
                    Area = 'P2S1baseArea',
                    Category = categories.FACTORY,
                    CompareOp = '<=',
                    Value = 0,
                    ArmyIndex = UEF,
                },
				{   
                    Area = 'P2S2baseArea',
                    Category = categories.FACTORY,
                    CompareOp = '<=',
                    Value = 0,
                    ArmyIndex = UEF,
                },
            },
        }
   )
    ScenarioInfo.M1P1:AddResultCallback(
    function(result)
        if(result) then
		 
           
        end
    end
)
   
end
 
