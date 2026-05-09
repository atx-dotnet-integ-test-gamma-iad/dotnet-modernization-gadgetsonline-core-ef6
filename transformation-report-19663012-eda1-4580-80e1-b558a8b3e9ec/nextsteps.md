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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

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

Navigate to the application in a browser and exercise the primary functionality to check for any runtime errors that would not have been caught at compile time.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm no runtime references remain.
- **HTTP modules and handlers**: These should have been migrated to ASP.NET Core middleware.
- **`ConfigurationManager`**: This should be replaced with `Microsoft.Extensions.Configuration`.
- **Entity Framework**: If the project uses Entity Framework 6, consider whether a migration to Entity Framework Core is needed for full cross-platform support.

### 6. Review `appsettings.json`

Confirm that any configuration previously held in `Web.config` has been correctly transferred to `appsettings.json` or `appsettings.{Environment}.json`, including connection strings and application settings.

### 7. Run Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

### 8. Verify Static Files and wwwroot

If this is a web project, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as required by ASP.NET Core's static file conventions.

### 9. Publish the Application

Once local validation is complete, produce a published output to confirm the deployment artifact is generated correctly:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.