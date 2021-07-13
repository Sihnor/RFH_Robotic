def main():
  # Einstellen des Werkzeugsgewichts in kg und im Schwerpunkt m
  mass  = 0.1
  cg = [0.0, 0.0, 0.0]
  set_payload(mass, cg)

  # Definieren des Werkzeugskoordinatensystems (TCP) in m und rad
  #                 X      Y      Z      RX     RY     RZ
  tcp_default = p[0.000, 0.000, 0.000, 0.000, 0.000, 0.000]
  set_tcp(tcp_default)

  # Definieren der Positionen
  posHome = [-1.57, -1.57, -1.57, -1.57, 1.57, -0.785]
  posTestUp = [-1.385, -2.418, -0.951, -1.353, 1.538, -0.525]
  posTestDown = p[0.035032, -0.802071, 0.170478, 1.079512, -2.917668, -0.022772]
  posPushUp = [-1.402, -2.814, -0.198, -1.709, 1.538, -0.543]
  posPushDown = p[0.035938, -0.892120, 0.174040, 1.079212, -2.917886, -0.022467]


  # Start Position anfahren
  movej(posHome, a=1.0, v=1.0, t=0, r=0)

  # Definition von Variablen
  cnt = 0
  analog = 0
  checkDefault = False
  checkPush = False
  set_standard_analog_out(0, 0)
  set_standard_digital_out(0,True)
  
  ### Start Program ###
  while True:
    analog = get_standard_analog_in(0)
    if analog > 9:
      ## Start Position ##
      movej(posTestUp, a=3, v=4, t=0, r=0)
      ## Pusch ##
      movel(posTestDown, a=0.2, v=0.2, t=0, r=0)
      sleep(0.2)
      checkPush = get_standard_digital_in(0)
      ## Start Position ##
      movel(posTestUp, a=0.5, v=0.5, t=0, r=0)
      movej(posHome, a=3, v=4, t=0, r=0)
      set_standard_analog_out(0, 0.2)
      sleep(1)
      set_standard_analog_out(0, 0)
    end
    if analog > 4 and analog < 6:
      ## Start Position ##
      movej(posPushUp, a=3, v=4, t=0, r=0)
      ## Pusch ##
      movel(posPushDown, a=0.2, v=0.2, t=0, r=0)
      sleep(0.2)
      checkDefault = get_standard_digital_in(0)
      ## Start Position ##
      movel(posPushUp, a=0.5, v=0.5, t=0, r=0)
      movej(posHome, a=3, v=4, t=0, r=0)
      ## Check ##
      if checkDefault == True and checkPush == False:
        set_standard_analog_out(0, 0.5)
        sleep(1)
        set_standard_analog_out(0, 0)
        textmsg("OK")
      else:
        set_standard_analog_out(0, 1)
        sleep(1)
        set_standard_analog_out(0, 0)
        textmsg("Kaputt")
      end 
    end
  end


### End Programm ###
  while True:
    cnt = cnt + 1
    sync()
  end

end
