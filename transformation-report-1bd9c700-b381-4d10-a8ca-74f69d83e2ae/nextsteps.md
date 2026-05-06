# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior matches the legacy version.

### 5. Execute the Test Suite

If test projects exist in the solution, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed Windows-Specific Dependencies

Check the project for any previously used Windows-specific APIs or packages that may have been removed or replaced during transformation, such as:

- `System.Web` references replaced by `Microsoft.AspNetCore.*`
- `HttpContext` usage updated to ASP.NET Core equivalents
- Any usage of `System.Drawing` which requires additional native dependencies on non-Windows platforms

### 7. Check Configuration Files

Verify that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Confirm connection strings, application settings, and any custom configuration sections have been migrated correctly.

### 8. Validate Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`, including:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` and `app.UseAuthorization()` if applicable

### 9. Database and Entity Framework Migrations

If the project uses Entity Framework, confirm the connection string targets the correct database and run the following to verify the model is in sync with the schema:

```bash
dotnet ef migrations list
dotnet ef database update
```

### 10. Deployment

Once all validation steps above pass without errors, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target hosting environment and confirm the application starts and operates correctly in that environment.