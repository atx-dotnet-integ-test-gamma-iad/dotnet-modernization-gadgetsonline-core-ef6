# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may need to be addressed.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, as some may indicate compatibility issues that did not surface as hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a currently supported version of .NET:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is set to an older or end-of-life version such as `netcoreapp3.1` or `net5.0`, update it to `net8.0` or `net6.0` (LTS releases).

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm expected behavior.

### 5. Check for Windows-Specific Dependencies

Review the codebase for any APIs or libraries that were Windows-specific in the original project, such as:

- `System.Web` references that may have been replaced with `Microsoft.AspNetCore` equivalents
- Windows Registry access
- COM interop
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core

### 6. Review Configuration Files

Confirm that configuration has been properly migrated:

- Verify that `Web.config` settings have been moved to `appsettings.json` or `appsettings.{Environment}.json`
- Check that connection strings are present and correctly formatted in the new configuration files
- Ensure environment-specific settings are accounted for

### 7. Database Connectivity

If the project uses a database, verify connectivity:

- Confirm the connection string in `appsettings.json` is correct
- If using Entity Framework, run the following to verify the model and database are in sync:

```bash
dotnet ef database update
```

- If migrations are missing, generate them:

```bash
dotnet ef migrations add InitialMigration
dotnet ef database update
```

### 8. Run Unit Tests

If the solution contains test projects, execute them to validate application logic:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 9. Review Static Files and Bundling

If the project serves static assets, confirm that:

- Static files are located in the `wwwroot` directory
- Any bundling or minification previously handled by `BundleConfig.cs` has been replaced with an appropriate alternative such as `LibMan`, `npm`, or a build tool like `webpack`

### 10. Verify Authentication and Authorization

If the application uses authentication, confirm that:

- The authentication middleware is correctly configured in `Program.cs` or `Startup.cs`
- Any forms authentication from the legacy project has been replaced with ASP.NET Core Identity or cookie authentication as appropriate
- Role and claims-based authorization behaves as expected

## Deployment

### 1. Publish the Application

Generate a publish output for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all expected files are present, including configuration files and static assets.

### 3. Deploy to the Target Environment

Copy the contents of the `./publish` directory to the target server or hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

If the runtime is not present, download and install it from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

### 4. Configure the Web Server

If hosting on IIS, ensure the ASP.NET Core Hosting Bundle is installed and the site is configured to use the `dotnet` process model. If hosting on Linux with Nginx or Apache, configure a reverse proxy to forward requests to the Kestrel server.