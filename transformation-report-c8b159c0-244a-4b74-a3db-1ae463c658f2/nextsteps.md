# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run the Application Locally
Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Check for Runtime Errors
Even without build errors, runtime issues can exist. Pay particular attention to:

- **Database connections**: Confirm connection strings in `appsettings.json` (or equivalent) are correct and that any Entity Framework migrations are up to date. Run `dotnet ef database update` if applicable.
- **Static files and wwwroot**: Verify that static assets (CSS, JS, images) are being served correctly.
- **Authentication/Authorization**: If the project uses ASP.NET Identity or cookie-based auth, confirm middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Configuration**: Ensure any settings previously in `Web.config` have been properly moved to `appsettings.json`.

### 6. Run Existing Tests
If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect actual regressions or test code that also needs to be updated for the new framework.

### 7. Review Removed or Changed APIs
Check the application for any use of APIs that were available in .NET Framework but have changed or been removed in modern .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these at the code level.

### 8. Publish the Application
Once the application has been validated locally, publish it to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files are present, then deploy the contents to your target environment.