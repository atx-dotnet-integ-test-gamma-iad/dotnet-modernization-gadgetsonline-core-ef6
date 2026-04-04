# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failures before proceeding.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **System.Web** references: These are not available in cross-platform .NET. If any code still references `System.Web`, it will need to be replaced with ASP.NET Core equivalents.
- **HttpContext** and **Session** usage: Confirm these have been migrated to the ASP.NET Core equivalents.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been updated to Entity Framework Core and that migrations are functioning correctly.
- **Configuration**: Confirm that `Web.config` has been replaced by `appsettings.json` and that configuration is being read using `IConfiguration`.

### 6. Run the Application Locally

Start the application locally using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and manually verify that core functionality, routing, and data access are working as expected.

### 7. Verify Database Connectivity

If the application connects to a database, confirm the connection string in `appsettings.json` is correct and that the application can read and write data without errors.

### 8. Review Publish Output

Perform a publish to confirm the output is complete and self-contained if required:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all necessary files, static assets, and configuration files are present.

### 9. Address Runtime Warnings

After running the application, review the console output and application logs for any runtime warnings that may indicate compatibility issues not caught at compile time.