def suma(a, b):
    return a + b

def resta(a, b):
    return a - b

def multiplicacion(a, b):
    return a * b

def division(a, b):
    if b == 0:
        return "No se puede dividir por cero"
    return a / b


print("Calculadora")
print('========================')
print("Seleccione operacion:")
print('========================')
print("1. suma")
print("2. resta")
print("3. multiplicacion")
print("4. division")

opcion = input("Ingrese opcion (1/2/3/4): ")

numero1 = float(input("Digite primer número: "))
numero2 = float(input("Digite segundo número: "))


if opcion == '1':
    print(suma(numero1, numero2))

elif opcion == '2':
    print(resta(numero1, numero2))

elif opcion == '3':
    print(multiplicacion(numero1, numero2))

elif opcion == '4':
    print(division(numero1, numero2))

else:
    print("Opcion no valida")