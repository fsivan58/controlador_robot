Prueba de commit


# Comparacion de STD_LOGIC
 IF reset = '1' THEN
         conta_unidades <=0;
         cuenta_espera <=0;
         led1<='1';
  ELSE
        cuenta_espera  <= cuenta_espera +1;
          if(cuenta_espera = espera) THEN
            cuenta_espera <=0;
            conta_unidades <= conta_unidades +1;
                if(conta_unidades =9) THEN 
                    conta_unidades <=0;
                END IF;
           END IF;
        END IF;
		
##-- Decodificador de 7 segmentos		
		          --GFEDCBA
display <= "1000000" WHEN conta_unidades =0 ELSE
           "1111001" WHEN contador_principal =1 ELSE
           "0100100" WHEN contador_principal =2 ELSE
           "0110000" WHEN contador_principal =3 ELSE
           "0011001" WHEN contador_principal =4 ELSE
           "0010010" WHEN contador_principal =5 ELSE
           "0000010" WHEN contador_principal =6 ELSE
           "1111000" WHEN contador_principal =7 ELSE
           "0000000" WHEN contador_principal =8 ELSE
           "1010101"; 
		   
##-- leds DE 7 SEGMENTOS pins to Artix 7	   
set_property PACKAGE_PIN K12 [get_ports {display_out[6]}]
set_property PACKAGE_PIN N9 [get_ports {display_out[5]}]
set_property PACKAGE_PIN R11 [get_ports {display_out[3]}]
set_property PACKAGE_PIN P11 [get_ports {display_out[2]}]
set_property PACKAGE_PIN R10 [get_ports {display_out[4]}]
set_property PACKAGE_PIN K13 [get_ports {display_out[1]}]
set_property PACKAGE_PIN T10 [get_ports {display_out[0]}]