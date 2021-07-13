def main():
  ### Gripper ###
  GripkitGripper1 = "CRG 30-050 SN:000311"  #Den nutzen da Langer Greifer#
  GripkitGripper2 = "CRG 30-050 SN:000312"

  GRIPKIT_NOT_REFERENCED = 0
  GRIPKIT_IDLE           = 1
  GRIPKIT_RELEASED       = 2
  GRIPKIT_NO_PART        = 4
  GRIPKIT_HOLDING        = 8

  ## Definition und Deklaration von Gripkit Funktionen ##
  def gripkit_grip(gripperID, gripIdx):
  gripkit_retval = gripkit_rpc.Grip(gripperID, gripIdx)
  end
  def gripkit_release(gripperID, gripIdx):
  gripkit_retval = gripkit_rpc.Release(gripperID, gripIdx)
  end
  def gripkit_reference(gripperID):
  gripkit_retval = gripkit_rpc.Reference(gripperID)
  end
  def gripkit_get_state(gripperID):
  gripkit_retval = gripkit_rpc.GetState(gripperID)
  return gripkit_retval
  end
  def gripkit_get_pos(gripperID):
  gripkit_retval = gripkit_rpc.GetPos(gripperID)
  return gripkit_retval
  end
  def gripkit_set_nopart_limit(gripperID, gripIdx, limit):
  gripkit_retval = gripkit_rpc.SetNoPartLimit(gripperID, gripIdx, limit)
  end
  def gripkit_set_release_limit(gripperID, gripIdx, limit):
  gripkit_retval = gripkit_rpc.SetReleaseLimit(gripperID, gripIdx, limit)
  end
  def gripkit_set_force(gripperID, gripIdx, force):
  gripkit_retval = gripkit_rpc.SetForce(gripperID, gripIdx, force)
  end
  def gripkit_set_override_grip(gripperID, override):
  gripkit_retval = gripkit_rpc.SetOverrideGrip(gripperID, override)
  end
  def gripkit_set_override_rel(gripperID, override):
  gripkit_retval = gripkit_rpc.SetOverrideRelease(gripperID, override)
  end
  def gripkit_store_remanent(gripperID):
  gripkit_retval = gripkit_rpc.StoreRemanent(gripperID)
  return gripkit_retval
  end
  def gripkit_set_vis_animation(gripperID, visIdx, animation):
  gripkit_retval = gripkit_rpc.SetLEDAnimation(gripperID, visIdx, animation)
  end
  def gripkit_set_vis_color(gripperID, visIdx, color):
  gripkit_retval = gripkit_rpc.SetLEDColor(gripperID, visIdx, color)
  end
  def gripkit_set_vis_speed(gripperID, visIdx, speed):
  gripkit_retval = gripkit_rpc.SetLEDSpeed(gripperID, visIdx, speed)
  end

  ## Greifer Initialisierung ##
  ##   Source: GRIPKIT by Weiss Robotics, 1.2.0, Weiss Robotics GmbH & Co. KG ##
  global gripkit_rpc=rpc_factory("xmlrpc", "http://127.0.0.1:44221/RPC2")
  gripkit_reference(GripkitGripper1)

  ## Greifer Konfigurieren ##
  gripkit_set_release_limit (GripkitGripper1,1,35.0) # <-- Konfigurieren fuer Greifer Aufgabe!
  gripkit_set_nopart_limit  (GripkitGripper1,1,12.0) # <-- Konfigurieren fuer Greifer Aufgabe!
  gripkit_set_force         (GripkitGripper1,1,50)   # <-- Konfigurieren fuer Greifer Aufgabe!
  gripkit_set_override_rel  (GripkitGripper1,50)
  gripkit_set_override_grip (GripkitGripper1,100)
  gripkit_store_remanent    (GripkitGripper1)


  ### Deffinitionen ###

  ## Einstellen des Werkzeugsgewichts in kg und im Schwerpunkt m ##
  mass  = 0.1
  cg = [0.0, 0.0, 0.0]
  set_payload(mass, cg)

  ## Definieren des Werkzeugskoordinatensystems (TCP) in m und rad ##
  ##                X      Y      Z      RX     RY     RZ
  tcp_default = p[0.000, 0.000, 0.000, 0.000, 0.000, 0.000]
  set_tcp(tcp_default)

  ## Definieren der Positionen ##
  posHome = [-4.7, -1.57, -1.57, -1.57, 1.57, 0]
  posStart = [-5.134, -2.402, -1.062, -1.255, 1.565, 1.179]
  posBand = p[0.420756, 0.666783, 0.078, 2.184248, -2.251963, 0.019716]
  posHalterUp = [-4.847, -2.863, -0.376, -2.813, 3.016, -1.360]
  posHalterDown = p[0.137365, 0.799858, 0.026590, -2.244947, -0.005279, 2.167423]
  posHalterEndUp = [-4.612, -2.430, -0.976, -1.306, 1.619, 0.137]
  posHalterEndDown = p[0.026506, 0.802440, 0.130393, 3.136029, -0.057857, -0.067987]
  posHalterPushUp = [-4.599, -2.218, -1.380, -1.113, 1.619, 0.151]
  posHalterPushDown = p[0.026123, 0.711310, 0.130393, 3.136296, -0.057506, -0.068696]
  posEndOk1Up = [-4.583, -1.995, -1.738, -0.934, 1.698, 1.759]
  posEndOk1Down = p[0.021472, 0.607337, 0.126701, 2.107269, -2.224388, -0.167651]
  posEndOk2Up = [-4.579, -1.948, -1.793, -0.926, 1.698, 1.764]
  posEndOk2Down = p[0.021409, 0.587477, 0.124992, 2.107331, -2.224228, -0.167391]
  posEndOk1PushUp = [-4.519, -1.956, -1.822, -0.936, 1.607, 0.242]
  posEndOk1PushDown = p[-0.004502, 0.580325, 0.134999, 3.132262, -0.073000, -0.048841]
  posEndOk2PushUp = [-4.510, -1.910, -1.896, -0.907, 1.607, 0.250]
  posEndOk2PushDown = p[-0.004492, 0.555840, 0.134999, 3.132348, -0.072886, -0.048878]
  posEndDefUp = [-5.8, -1.8, -1.9, -0.9, 1.56, -2.7]
  posEndDefDown = p[0.527333, 0.143029, 0.104771, 2.172347, 2.230440, 0.066433]

  ## Fliessbandverfolgung ##
  set_standard_analog_out(0, 0)
  encoder_enable_pulse_decode(0,1,0,1)

  ### Funktionen ###
  def warning(status):
    if (status == True):
      gripkit_set_vis_animation(GripkitGripper1, 0, 3)
      gripkit_set_vis_color(GripkitGripper1, 0, 1)
      gripkit_set_vis_speed(GripkitGripper1, 0, 4)
      movej(posHome, a=1.0, v=1.2, t=0, r=0)
    else:
      gripkit_set_vis_animation(GripkitGripper1, 0, 0)
      gripkit_set_vis_color(GripkitGripper1, 0, 0)
      gripkit_set_vis_speed(GripkitGripper1, 0, 0)
    end
  end

  ## Definition von Variablen ##
  cnt = 0
  trash = 0
  okHolder = 0
  okCycle = True
  warning(False)

  ### LED und Quitierung ###
  thread led():
    while True:
      ## Setzen der LED zustände ##
      if (okHolder < 2 and trash < 2 and okCycle == True):
        set_standard_digital_out(4, True)
      else:
        set_standard_digital_out(4, False) 
      end
      if (trash == 2):
        set_standard_digital_out(5, True)
      else:
        set_standard_digital_out(5, False) 
      end

      ## Quitierung beachten ##
      if (get_standard_digital_in(4)==True):
        okHolder = 0
        okCycle = True
        warning(False)
      end
      if (get_standard_digital_in(5)==True):
        trash = 0
        okCycle = False
      end

    end
    return False
  end

  ## Thread Starten ##
  thrd = run led()



  ### Start Programm ###
  movej(posHome, a=1.0, v=1.2, t=0, r=0)
  while True:
    ## Definition von Variablen ##
    light = get_digital_in(3)
    analog = get_standard_analog_in(0)
    testCheck = False
    pushCheck = False

    ## Prüfen ob alle behälter Bereit sind und ob Cycle ok ist##
    if (trash == 2 or okHolder == 2):
      movej(posHome, a=1, v=1.2, t=0, r=0)
      while trash == 2 or okHolder == 2:
      end
    end
    # Cycle OK #
    while okCycle == False:
    end


    ## Block Aufnehmen vom Band ##
    if (okCycle == True):
      # Startposition Anfahren #
      movej(posStart, a=3, v=4, t=0, r=0)

      # Aufnehmen vom Band #
      while gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING and  okCycle == True:
        light = False
        gripkit_release(GripkitGripper1,1)

        # Starten wen Lichtschranke Go #
        while light == False and  okCycle == True:
          light = get_digital_in(3)
          if light == True:
            track_conveyor_linear(p[0,1,0,0,0,0], 22500 ,0)
          end
        end
        if (okCycle == True):
          # Greifen #
          movel(posBand, a=0.5, v=0.15, t=0, r=0)
          gripkit_grip(GripkitGripper1,1)
          while gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING and gripkit_get_state(GripkitGripper1) != GRIPKIT_NO_PART:
          end
          movel(posStart, a=0.5, v=0.15, t=0, r=0)
          stop_conveyor_tracking(0)

          # Prüfen ob Objekt gegriffen wurde #
          if gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING:
            movej(posStart, a=1, v=1.2, t=0, r=0)
          end
        end
      end
    else:
      warning(True)
    end


    ## Block In den halter bringen ##
    if (okCycle == True):
      # In den Halter bringen #
      movej(posHalterUp, a=3, v=4, t=0, r=0)
      movel(posHalterDown, a=0.5, v=0.05, t=0, r=0)
      if (gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING):
        okCycle = False
      end
      gripkit_release(GripkitGripper1,1)
      movel(posHalterUp, a=0.5, v=0.05, t=0, r=0)
      movej(posHome, a=3, v=4, t=0, r=0)
      
      # Handshake #
      if (okCycle == True):
        set_standard_analog_out(0, 1)
        sleep(1)
        set_standard_analog_out(0, 0)
      end
    else:
      warning(True)
    end
    ## Block after Test Chack ##
    if (okCycle == True):
      while testCheck == False:
        analog = get_standard_analog_in(0)

        # Umsetzen in anderen Halter #
        if analog > 1 and analog < 3:
          testCheck = True
          movej(posHalterEndUp, a=3, v=4, t=0, r=0)
          movel(posHalterEndDown, a=0.5, v=0.05, t=0, r=0)
          gripkit_grip(GripkitGripper1,1)
          while gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING and gripkit_get_state(GripkitGripper1) != GRIPKIT_NO_PART:
          end
          if gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING:
            movel(posHalterEndUp, a=0.5, v=0.05, t=0, r=0)
            warning(True)
            okCycle = False
          elif (okCycle == True):
            movel(posHalterEndUp, a=0.5, v=0.05, t=0, r=0)
            movej(posHalterPushUp, a=3, v=4, t=0, r=0)
            movel(posHalterPushDown, a=0.5, v=0.05, t=0, r=0)
            if (gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING):
              okCycle = False
              warning(True)
            else:
              gripkit_release(GripkitGripper1,1)
              movel(posHalterPushUp, a=1.0, v=1.0, t=0, r=0)
            end
            movej(posHome, a=1.0, v=1.2, t=0, r=0)
            # Handshake #
            if (okCycle == True):
              set_standard_analog_out(0, 0.5)
              sleep(1)
              set_standard_analog_out(0, 0)
            end
          end
        end
      end
    else:
      warning(True)
    end

    ## Block after Push Chack ##
    if (okCycle == True):
      while pushCheck == False:
        analog = get_standard_analog_in(0)

        # Nicht OK dann in den Müll #
        if analog > 9:
          pushCheck = True
          movej(posHalterPushUp, a=3, v=4, t=0, r=0)
          movel(posHalterPushDown, a=0.5, v=0.05, t=0, r=0)
          gripkit_grip(GripkitGripper1,1)
          while gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING and gripkit_get_state(GripkitGripper1) != GRIPKIT_NO_PART:
          end
          if gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING:
            movel(posHalterPushUp, a=0.5, v=0.05, t=0, r=0)
            warning(True)
            okCycle = False
          elif (okCycle == True):
            movel(posHalterPushUp, a=0.5, v=0.05, t=0, r=0)
            movej(posEndDefUp, a=3, v=4, t=0, r=0)
            movel(posEndDefDown, a=1.0, v=1.0, t=0, r=0)
            if (gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING):
              okCycle = False
              warning(True)
            else:
              gripkit_release(GripkitGripper1,1)
              movel(posEndDefUp, a=1.0, v=1.0, t=0, r=0)
              trash = trash + 1
            end
          end
        
        # Ok dann auf den halter #
        elif analog > 4 and analog < 6:
          pushCheck = True
          # Vom Halter Aufnehmen #
          movej(posHalterPushUp, a=3, v=4, t=0, r=0)
          movel(posHalterPushDown, a=0.5, v=0.05, t=0, r=0)
          gripkit_grip(GripkitGripper1,1)
          while gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING and gripkit_get_state(GripkitGripper1) != GRIPKIT_NO_PART:
          end
          if gripkit_get_state(GripkitGripper1) != GRIPKIT_HOLDING:
            movel(posHalterPushUp, a=0.5, v=0.05, t=0, r=0)
            warning(True)
            okCycle = False
          elif (okCycle == True):
            movel(posHalterPushUp, a=0.5, v=0.05, t=0, r=0)
            if (okHolder == 0):
              movej(posEndOk1Up, a=3, v=4, t=0, r=0)
              movel(posEndOk1Down, a=0.5, v=0.05, t=0, r=0)
              gripkit_release(GripkitGripper1,1)
              movel(posEndOk1Up, a=0.5, v=0.4, t=0, r=0)
              movej(posEndOk1PushUp, a=3, v=4, t=0, r=0)
              movel(posEndOk1PushDown, a=0.5, v=0.4, t=0, r=0)
              movel(posEndOk1PushUp, a=1, v=1.2, t=0, r=0)
              okHolder = okHolder + 1
            elif (okHolder == 1):
              movej(posEndOk2Up, a=3, v=4, t=0, r=0)
              movel(posEndOk2Down, a=0.5, v=0.05, t=0, r=0)
              gripkit_release(GripkitGripper1,1)
              movel(posEndOk2Up, a=0.5, v=0.4, t=0, r=0)
              movej(posEndOk2PushUp, a=3, v=4, t=0, r=0)
              movel(posEndOk2PushDown, a=0.5, v=0.4, t=0, r=0)
              movel(posEndOk2PushUp, a=1, v=1.2, t=0, r=0)
              okHolder = okHolder + 1
            else:
              movel(posHalterPushUp, a=0.5, v=0.05, t=0, r=0)
              warning(True)
              okCycle = False
            end
          end
        end
      end
    else:
      warning(True)
    end
  end


  
### End Programm ###
  while True:
    cnt = cnt + 1
    sync()
  end

end
