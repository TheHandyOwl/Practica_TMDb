//: Playground - noun: a place where people can play

import TMDbCore
import RxSwift
import PlaygroundSupport

// Para tener el playground ejecutando de manera infinita
PlaygroundPage.current.needsIndefiniteExecution = true

enum APIError: Error {
    case invalidKey
    case notAnImage
}

//OJO: dejar los campos igual al json para que pueda deserializar el json con el protocolo Decodable
struct UserResponse: Decodable {
    struct User: Decodable {
        struct Name: Decodable {
            let title: String
            let first: String
            let last: String
        }
        
        struct Picture: Decodable {
            let large: URL
        }
        
        let name: Name
        let picture: Picture
    }
    
    let results: [User]
    //let fistro: String // Esto provocaría un error en el parseo
}

// Observables 1 a 1
let empty = Observable<Int>.empty() // Secuencia de eventos observables vacía
let single = Observable.just("Hello") // Emite un evento next y un evento complited. Se infiere que es String. No lo indicamos por eso
let some = Observable.from(["🤔", "🤡"]) // Emite 3 eventos con el complete
let error = Observable<Data>.error(APIError.invalidKey)

// Observables anteriores en 1
//let hello = Observable<String>.create(<#T##subscribe: (AnyObserver<String>) -> Disposable##(AnyObserver<String>) -> Disposable#>)
// AnyObserver es nuestro futuro suscriptor
// Disposable se infiere, y por eso se elimina
// A este observer se le mandan los eventos
// Resumen: Suscripción a la secuencia de eventos
let hello = Observable<String>.create { (observer) in
    observer.onNext("Hello")
    observer.onNext("World")
    observer.onCompleted()
    
    return Disposables.create() // El método create recibe un closure que ejecutará un código cada vez que se reciba un evento
}

// Sin encapsular
print("Ejemplo: Sin encapsular")
hello.subscribe { event in
    switch event {
    case .next(let value):
        print("El evento es \(value)")
    case .error(let error):
        print("El error es \(error)")
    case .completed:
        print("Completed")
    }
}

// Liberando recursos en tareas síncronas
print("Ejemplo: No tiene sentido liberar recursos en tareas síncronas porque ya se han ejecutado las tareas")
let d = hello.subscribe { event in
    switch event {
    case .next(let value):
        print("El evento es \(value)")
    case .error(let error):
        print("El error es \(error)")
    case .completed:
        print("Completed")
    }
}
d.dispose() // Se han realizado todas las tareas al llegar


// Encapsulado
print("Ejemplo: Encapsulado")
let session = URLSession(configuration: .default)
let apiURL = URL(string: "https://randomuser.me/api")!
// let apiURL = URL(string: "https://randomuser.me/api/blablabla")! // Esto también generaría un error JSON, o puede ser un 404
let decoder = JSONDecoder()

func data (with url: URL) -> Observable<Data> {
    return Observable<Data>.create { observer in
        let task = session.dataTask(with: url) { data, _, error in // Cuando llega la información
            if let error = error {
                observer.onError(error) // No autocompleta pero es así
            } else {
                observer.onNext(data ?? Data()) // Devolvemos los datos así porque data es opcional
                observer.onCompleted()
            }
        }
        task.resume() // Aquí ejecutamos la tarea, la task de URLSession
        
        return Disposables.create { // Cuando se destruya, ejecutará esta cancelación
            print("Cancelled")
            task.cancel()
        }
    }
}

func randomUser(with url: URL) -> Observable<UserResponse> {
    return data(with: url).map { data in
        try decoder.decode(UserResponse.self, from: data)
    }
}

func image (with url: URL) -> Observable<UIImage> {
    return data(with: url).map {
        guard let image = UIImage(data: $0) else {
            throw APIError.notAnImage
        }
        return image
    }
}

let disposeBag = DisposeBag()

randomUser(with: apiURL)
    .map { $0.results[0] }
    .flatMap { user in
        return image(with: user.picture.large)
    }
    .observeOn(MainScheduler.instance) // Devuelve la imagen al hilo principal y sigue en el principal. Cuanto más abajo menos recusos come al principal. Lo suyo es que consuma en segundo plano
    .subscribe(onNext: {
        let image = $0 // Parece que en los playgrounds no funciona la visualización y por eso el temp
        print("image-image: \(image)")
        print("image-$0: \($0)")
        //print(String(data: data, encoding: .utf8)!)
    }, onError: { error in
        print("Error del disposable: \(error)") // Si tenemos varias tareas, en el momento que 1 de ellas falla cancela todo
        
    })
    .disposed(by: disposeBag) // Añade la suscripción al conenedor para luego cancelarlas todas de golpe


// Ejemplo de map y flatMap
let cell = UITableViewCell()
let size = cell.imageView?.image?.size // Un '?' u 'Optional Chaining' es un flatMap
let size2 = cell.imageView.flatMap { $0.image }.flatMap { $0.size } // Es lo mismo que antes

// Sin la siguiente línea se imprime el mensaje y cancela cuando termina de reicbir los datos
//disposable.dispose()  // Si pongo el dispose se cancela y no se imprime el mensaje anterior
// Si se ejecuta cuando realmentetermina, cancela algo que ya no existe
