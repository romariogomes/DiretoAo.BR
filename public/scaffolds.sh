rails generate scaffold User name:string email:string password_digest:string

rails generate scaffold Law_project law_number:integer description:text date:date
rails generate scaffold Politician name:string birthdate:date party:string photo:string
rails generate model Politician_law politician:references law_project:references

rails generate scaffold Charge charge_name:string
rails generate scaffold State state_name:string

rails generate migration AddForeignKeyToPoliticians charge:references state:references

rails generate scaffold Experience title:string init_year:integer end_year:integer
rails generate migration AddForeignKeyToExperiences politician:references

rails generate scaffold Notice title:string url:string
rails generate migration AddForeignKeyToNotices politician:references

rails generate scaffold Interaction
rails generate migration AddForeignKeyToInteractions user:references law_project:references notice_references

rails generate scaffold Acceptance like:boolean
rails generate migration AddForeignKeyToAcceptances interaction:references

rails generate scaffold Comment description:text comment_father:integer
rails generate migration AddForeignKeyToComments interaction:references

