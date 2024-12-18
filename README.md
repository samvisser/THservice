This is the data service application for the TutorsHub project, which is deployed here:

[Link to our Azure database](https://calvintutorshub.azurewebsites.net/)

The service exposes the following read data route URLs:

`/` - A hello message 

`/users` - A list of users (students and tutors)  

`/users/:id` - A single user with the given ID  

`/tutors` - A list of tutors

`/tutors/:name` - Information for a given user 

`/courseCodes` - A list of courses offered

`/courseCodes/:code` - Information for a given course

The database is relational, with the schema specified in the sql/ sub-directory, and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/). Database server details, along with user and password credentials, are stored as Azure application settings to ensure they are not exposed in this (public) repository.

We implement this service as a separate repository to simplify Azure integration. It is easier to auto-deploy a separate repository to Azure.
