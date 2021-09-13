# FLUTTER API CALL

![Register Screen](https://github.com/parikshitg/flutter_api_call/blob/master/flutter_client/assets/images/ss1.png)
![List Screen](https://github.com/parikshitg/flutter_api_call/blob/master/flutter_client/assets/images/ss2.png)

This projects demonstrates the ideal way to make api calls in flutter. The app consists of a basic auth flow. User can register, login, update its credentials and remove from the app covering the basic http methods GET, POST, PATCH, DELETE.

The project-repo consist of two directories, **flutter_client** (our frontend client app written in flutter) and **go-server** backend server written in golang. The go-server is a small API based microservice written using gin-gonic.


### REQUIREMENTS
*  Computer
*  Golang 
*  Flutter

### RUN
To run golang backend server:

```
cd flutter_api_call/go-server
make run or go run main.go  
```

To run flutter app:
 
```
cd flutter_api_call/flutter_client
flutter pub get
flutter run
```
	
### API SPECS
Some common structures:

```
Status{
	Success      `json:"success"`		// boolean
	ErrorMessage `json:"error_message"` 	// string
}

Response{
	Status `json:"status"` 			// Status
}

User{
	Name    `json:"name"`                   // string
	Email 	`json:"email"`                  // string
}

```


#### __/register__ 

```
* Method: POST
* Request: RegisterRequest{
		Email 		 `json:"email"` 		// string
		Name		 `json:"name"`  		// string
		Password	 `json:"password"` 	        // string
		ConfirmPassword `json:"confirm_password"` 	// string
	    }
* Response: Response{}
```

#### __/login__
 
```
* Method: POST
* Request: LoginRequest{
		Email	    `json:"email"`     // string
		Password    `json:"password"`  // string
		}
* Response: LoginResponse{
		Name  `json:"name"` 	 	// string
		Email `json:"email"` 	 	// string
		}
```

#### __/list__ (lists all the users)

```
* Method: GET
* Response: ListResponse{
		Status  `json:"status"` 	// Status
		Users   `json:"users"` 	// []User
	    }
```

#### __/update-password__

```
* Method: PATCH
* Request: UpdateRequest{
		Email 		 `json:"email"` 		// string
		OldPassword 	 `json:"old_password"`         // string
		NewPassword     `json:"new_password"` 	// string
		ConfrimPassword `json:"confirm_password"` 	// string
		}
* Response: Response{}
```

#### __/delete__

```
* Method: DELETE
* Request: DeleteRequest{
		Email 	    `json:"email"` 	 // string
		Password    `json:"password` 	 // string
	}
* Response: Response{}
```
