# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to `net8.0` as those versions are no longer in long-term support.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which have changed in ASP.NET Core
- Windows-specific APIs such as the registry, WCF server-side components, or Windows Communication Foundation
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 6. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains all configuration values that were previously in `web.config` or `app.config`.
- Verify that connection strings, application settings, and environment-specific values have been migrated correctly.
- Remove or archive any legacy `web.config` entries that are no longer applicable.

### 8. Verify Static Assets and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Ensure the following are present where applicable:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();
```

### 9. Test on Target Deployment Platform

Run the application on the operating system or environment where it will ultimately be deployed. Cross-platform .NET behaves consistently across platforms, but file path casing, environment variables, and platform-specific dependencies should be verified.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present before deploying to the target environment.