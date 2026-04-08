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

Review the output for any warnings related to missing packages, deprecated package versions, or compatibility issues with the target framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Review the output and address any warnings that could indicate runtime issues, even if they do not prevent compilation.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your deployment environment.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by transformation-related changes or pre-existing issues.

### 5. Check for Removed or Replaced APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Review the code for usage of the following common incompatible areas:

- `System.Web` namespace (e.g., `HttpContext`, `HttpRequest` in the old style)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` members that are not supported in .NET Core and later
- `BinaryFormatter` (deprecated and disabled by default)
- WCF server-side components

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining incompatible API calls.

### 6. Verify Configuration Files

.NET Framework projects relied on `Web.config` or `App.config`. Cross-platform .NET uses `appsettings.json` and the `Microsoft.Extensions.Configuration` stack. Confirm that:

- All connection strings have been migrated to `appsettings.json`
- All `<appSettings>` keys have been moved to the appropriate configuration provider
- Environment-specific configuration (e.g., `appsettings.Development.json`) is in place

### 7. Run the Application Locally

Start the application locally and perform manual smoke testing of core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the primary workflows of the application and confirm expected behavior.

### 8. Review Static Files and Middleware

If `GadgetsOnline` is a web application, verify that static file serving, routing, and middleware configuration in `Program.cs` or `Startup.cs` are correctly set up for ASP.NET Core conventions.

### 9. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string is correctly configured in `appsettings.json`
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- Data access operations function correctly during local testing.

### 10. Address Any Runtime Warnings or Exceptions

Run the application under realistic conditions and monitor the console output and any configured logging sinks for exceptions or warnings that did not surface at compile time.