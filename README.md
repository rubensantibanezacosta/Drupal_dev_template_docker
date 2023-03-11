# Drupal DEV template Docker :whale:


This is a template for a **Drupal 10** development environment, extremely editable and easy to use. It is based on Docker and Docker Compose, and it is intended to be used with a local development environment.

## Getting Started :rocket:

Clone this repository:
    


    git clone https://github.com/rubensantibanezacosta/Drupal_dev_template_docker.git

  

Changue git remote to your own repository:
    
  

    git remote set-url origin YOUR_REPO_URL


Configure your local environment:
    
 
    cp .env.example .env
   

Edit the `.env` file and change the following variables. 

- By default, the database is configured to use `MySQL`, at the moment, it is the only database supported. If you want to use another database, you will have to change the `docker-compose.yml` file and the `.env file. In the future, I will add support for other databases upon request.

- By default, the `Drupal` installation is configured to use the default english language, but you can change it to spanish by changing the `DRUPAL_LOCALE` variable to `es`. If you want to use another language, you will add the corresponding language `.po` file to the `./drupal/config/translations` folder, and change the `DRUPAL_LOCALE` variable to the corresponding language code. In the future, I will add support for other languages upon request.

    ```
    # MySQL variables
    MYSQL_USER=
    MYSQL_ROOT_PASSWORD=
    MYSQL_PASSWORD=
    MYSQL_DATABASE=

    # Drupal variables
    DB_NAME=
    DB_USER=
    DB_PASSWORD=
    DB_ROOT_PASSWORD=
    DB_HOST=mysql
    DB_PORT=3306
    DB_DRIVER=mysql

    DRUPAL_USER=
    DRUPAL_PASSWORD=
    DRUPAL_SITE_NAME=
    DRUPAL_LOCALE=es
    DRUPAL_SITE_MAIL=

    ```

You can also add extra modules to the Drupal installation by adding reference in `composer.json`  file, and the name of the module in the `extra_modules.txt` file. The modules will be installed automatically when you run the docker-compose up command. Separate them with a line break. For example:

For adding `Pathauto` module:

- Add the following line to the `composer.json` file:
    

    
    ```json

      "require": {
        ...
        "drupal/pathauto": "^1.11"
    },

    ```
- Add the following line to the `extra_modules.txt` file:
    
    ```
    pathauto
    ```

To start the environment, run the following command:
    

    docker-compose up --build
  

To stop the environment, run the following command:
    
  

    docker-compose down

   


### Prerequisites :page_with_curl:

The things you need before installing the software.

* **Docker** - [https://docs.docker.com/install/](https://docs.docker.com/install/)
* **Docker Compose** - [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)


## Usage :computer:

When you run the `docker-compose up` command, the following containers will be created:

* **Drupal**: The `Drupal` container, which contains the `Drupal` installation.
* **MySQL**: The `MySQL` container, which contains the database.

The `Drupal` container is configured to use the following ports:

* _8080_: The port where the Drupal site will be available.

The `MySQL` container is configured to use `Docker`'s internal network, so it is not necessary to expose any port.

When you initialize the environment, the default Drupal installation will be downloaded and installed. You can access the site at http://localhost:8080. 


The project is configured to install site on the first run, so it will skip the installation process if you run the docker-compose up command again, but you can add more modules after the first run following the instructions in the `Getting Started` section, and it will install them automatically.



