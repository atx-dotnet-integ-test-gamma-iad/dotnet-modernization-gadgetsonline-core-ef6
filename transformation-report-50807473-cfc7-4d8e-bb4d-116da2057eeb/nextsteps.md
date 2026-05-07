# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without introducing any compilation issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`).
- There are no remaining references to `net48`, `net472`, or other legacy .NET Framework monikers.
- NuGet package references have been updated to versions compatible with the target framework.

### 2. Restore and Build Locally

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Ensure there are no warnings that could indicate deprecated APIs or packages that may cause runtime issues.

### 3. Run the Test Suite

If the solution contains a test project, execute the tests to verify runtime behavior has not changed:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 4. Check for Removed or Changed APIs

Inspect the codebase for usage of APIs that were available in .NET Framework but have changed behavior or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` usages — this namespace is not available in cross-platform .NET. If the project is a web application, confirm it has been migrated to ASP.NET Core equivalents.
- `ConfigurationManager` — should be replaced with `Microsoft.Extensions.Configuration`.
- `HttpContext` and related types — confirm they reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- Windows-specific APIs (e.g., registry access, `System.Drawing` without the `System.Drawing.Common` package) — these may fail on non-Windows platforms.

### 5. Run the Application Locally

Start the application and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that:

- The application starts without exceptions.
- Core features (e.g., product listing, cart, checkout if applicable) function as expected.
- Database connections and any external service integrations are operational.

### 6. Verify Configuration Files

Check `appsettings.json` (or equivalent) to confirm:

- Connection strings are present and correct.
- Any environment-specific settings previously stored in `Web.config` or `App.config` have been migrated appropriately.
- Logging configuration is in place.

### 7. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 8. Review NuGet Dependencies

Run the following to check for outdated or vulnerable packages:

```bash
dotnet list package --outdated
dotnet list package --vulnerable
```

Update any packages flagged as vulnerable and evaluate whether outdated packages should be updated before deployment.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

Review the output in the `./publish` directory and confirm all required files are present before deploying to the target environment.