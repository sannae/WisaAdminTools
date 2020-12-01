# Fai un check (con la funzione Invoke-WebRequest) che l'applicazione web non risponda con errori di IIS

$AppName = "mpassw"

if ( (Invoke-WebRequest "http://localhost/$AppName").StatusCode -ne 200 ) {
    # Do stuff (a seconda dell'errore)
}