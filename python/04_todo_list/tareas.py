tareas = []
def agregar_tarea(tarea):
    tareas.append(tarea)
    print("tarea agregada")

def mostrar_tareas(tareas):
        print("tareas:")
        for t in tareas:
            print(t)

def eliminar_tarea(tarea):
        if tarea in tareas:
            tareas.remove(tarea)
            print("tarea eliminada")
        else:
            print("tarea no encontrada")

while True:

    print("========================")
    print("1.agregar tarea")
    print("2.mostrar tareas")
    print("3.eliminar tarea")
    print("========================")
    
    opcion = input("seleccione una opcion:")
   
    if opcion not in ["1", "2", "3", "4"]:
        print("opcion no valida")
        

    elif opcion == "1":
        tarea = input("ingrese la tarea:")
        agregar_tarea(tarea)
        
    elif opcion == "2":
        mostrar_tareas(tareas)

    elif opcion == "3":
        tarea = input("ingrese la tarea a eliminar:")
        eliminar_tarea(tarea)





          
    

    