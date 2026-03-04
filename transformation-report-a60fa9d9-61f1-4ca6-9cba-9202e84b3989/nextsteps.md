# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that the output reports `0 Error(s)` and `0 Warning(s)` (or review any warnings for potential runtime issues).

### 2. Review Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets the intended .NET version (e.g., `net8.0` or `net6.0`).
- Any NuGet package references are up to date and compatible with the target framework.
- No legacy `<Reference>` elements pointing to GAC or Windows-specific assemblies remain.

### 3. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently or have been removed in modern .NET. Review the code for:

- Usage of `System.Web` namespaces, which are not available outside of ASP.NET on .NET Framework.
- Any `HttpContext`, `HttpRequest`, or `HttpResponse` usages that may need to be updated to their ASP.NET Core equivalents.
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches the legacy version. Pay particular attention to:

- Database connectivity and query results.
- Authentication and session handling.
- Any file I/O operations that may rely on paths previously relative to `App_Data` or similar ASP.NET Framework conventions.

### 5. Run Existing Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review any failing tests and determine whether the failures are due to migration-related behavioral changes or pre-existing issues.

### 6. Verify Static Files and Views

If this is a web application, confirm that:

- Static files (CSS, JavaScript, images) are served correctly under `wwwroot`.
- Razor views or pages render without runtime errors.
- Any `bundleconfig.json` or asset pipeline configuration is functional.

### 7. Review Configuration Files

- Ensure `appsettings.json` contains the configuration values that were previously in `web.config` or `app.config`.
- Confirm connection strings, app settings, and environment-specific overrides are correctly structured.

### 8. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish -c Release -o ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present, then deploy the output to the target hosting environment (IIS, Linux server, Azure App Service, etc.) according to the standard process for that environment.