# Demo Static Website uring AWS S3
This project demonstrates how to use AWS S3 to host a static website.
The project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 11.2.3.

## How to Develop
### Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

### Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

### Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

### Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

### Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).

## How to Deploy

### Pre-requisites
You need NodeJs and Angular CLI to build the project.
1. Install latest version of NodeJs from [here](https://nodejs.org/en/download/) (Tested version: v14.16.0)
2. Install Angular CLI by following the instructions [here](https://angular.io/cli) (Tested version: 11.2.3)

The project uses AWS CLI to provision AWS resources and deploy the website. You also need an IAM user account to authenticate to AWS when using CLI.
1. Install AWS CLI by following the instructions available [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)
2. Follow the [quick configuration steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config) to configure your credentials

### Deploy to AWS
All the steps required to build and deploy are scripted in the `Deploy.ps1` PowerShell script.

```
.\Deploy.ps1 -BucketName <your-s3-bucket-name> -Build -UseCloudFront
```

* `BucketName`: Specify globaly a unique name for the target S3 bucket name. This will be created if does not exist.
* `Build`: Specify this switch if you want to build the Angular application.
* `UseCloudFront`: Specify this switch if you want to expose the website using a CloudFront distribution