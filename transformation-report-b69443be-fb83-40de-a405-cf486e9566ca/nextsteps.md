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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run Unit Tests

If the solution contains any test projects, execute the tests to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime.

### 5. Check for Platform-Specific Code

Search the codebase for any APIs that were available in .NET Framework but may behave differently or be unavailable in cross-platform .NET. Common areas to check include:

- `System.Web` usages (not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side code
- `AppDomain` usage
- Any P/Invoke calls targeting Windows-specific native libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify remaining compatibility concerns.

### 6. Run the Application Locally

Start the application locally and manually verify that core functionality works as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the key workflows of the application (e.g., product browsing, cart, checkout if applicable) and confirm there are no runtime exceptions.

### 7. Review Configuration Files

Ensure that configuration files have been properly migrated:

- `web.config` settings should be moved to `appsettings.json` where applicable.
- Connection strings, app settings, and environment-specific values should be verified in the new configuration system.
- Middleware configuration previously in `Global.asax` or `Startup.cs` (OWIN) should be confirmed in the ASP.NET Core `Program.cs` or `Startup.cs`.

### 8. Verify Static Files and Routing

Confirm that static file serving (CSS, JavaScript, images) and routing behave correctly under ASP.NET Core conventions, as these differ from the legacy ASP.NET MVC or Web Forms model.

### 9. Database Connectivity

If the project uses a database, verify that:

- The connection string is correctly configured in `appsettings.json`.
- Entity Framework (if used) has been migrated to Entity Framework Core, and any pending migrations are applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Publish the Application

Once all validation steps pass, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required assets, configuration files, and binaries are present before deploying to the target environment.