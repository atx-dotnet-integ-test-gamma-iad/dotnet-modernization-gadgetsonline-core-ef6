# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that may indicate deprecated APIs or compatibility concerns, even if they do not prevent a successful build.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a .NET Framework moniker such as `net48`).

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to identify any runtime errors that would not surface at build time.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 6. Review Removed or Replaced APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespaces (replaced by `Microsoft.AspNetCore`)
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain `System.Drawing` features
- `BinaryFormatter` (removed in modern .NET)

Address any identified usages by replacing them with their supported cross-platform equivalents.

### 7. Review Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` or the appropriate ASP.NET Core configuration system. Connection strings, application settings, and environment-specific values should all be accounted for.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings are correct for the target environment and that the data access layer functions as expected at runtime.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.

### 10. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

The runtime version should match or be compatible with the `<TargetFramework>` specified in the project file. Start the application and perform a final round of validation in the target environment.