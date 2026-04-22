# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, certain APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `App.config` or `Web.config` sections (replaced by `appsettings.json`)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary functionality to confirm runtime behavior matches expectations from the original project.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral differences introduced during the migration.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the necessary configuration values previously held in `Web.config`.
- Verify that static files (CSS, JavaScript, images) are placed under the `wwwroot` folder, as required by ASP.NET Core.
- Check that any connection strings have been correctly migrated to `appsettings.json` or environment variables.

### 8. Verify Database Connectivity

If the application uses a database, confirm the connection string is correct and that the application can connect successfully at runtime. If Entity Framework is in use, verify that migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.