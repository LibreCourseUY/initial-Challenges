import random

secreto = random.randint(1, 10) 

print("Adivina el número del 1 al 10")


intento = 0

while intento != secreto:
    
    intento = int(input("¿Qué número crees que es?: "))

    
    if intento < secreto:
        print("Mas arriba")
    elif intento > secreto:
        print("Mas abajo")

print("¡Ganaste!")
