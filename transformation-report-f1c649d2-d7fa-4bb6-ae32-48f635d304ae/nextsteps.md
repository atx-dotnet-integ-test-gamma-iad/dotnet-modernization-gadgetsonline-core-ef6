# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review test results and address any failures before proceeding.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs that were available in .NET Framework but may behave differently or be unavailable in cross-platform .NET, including:

- `System.Web` references
- Windows Registry access (`Microsoft.Win32.Registry`)
- `HttpContext.Current` usage
- `AppDomain` members that are no longer supported
- Any P/Invoke calls targeting Windows-specific libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to assist with this review.

### 7. Validate Configuration

Confirm that any `Web.config` or `App.config` settings have been correctly migrated to `appsettings.json` and that environment-specific configuration is handled through the `IConfiguration` system.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can connect and perform basic operations against the database.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is well-formed:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, static files, and configuration files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it behaves consistently with the local development run:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Verify that the application starts without errors and responds correctly to requests.