# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of the **GadgetsOnline** solution appears to have completed successfully, as there are no build errors present in the project.

## Validation Steps

### 1. Restore Dependencies
Run the following command to ensure all NuGet packages are restored correctly:
```bash
dotnet restore
```
Verify that no warnings or errors appear during the restore process.

### 2. Build the Solution
Perform a full build to confirm the solution compiles cleanly:
```bash
dotnet build --configuration Release
```
Review the output for any warnings that may indicate compatibility issues even if the build succeeds.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a legacy `net48` or similar framework moniker.

### 4. Run the Application Locally
Start the application using:
```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```
Navigate through the application's core functionality to confirm runtime behavior matches expectations from the legacy version.

### 5. Run Existing Tests
If a test project exists within the solution, execute the test suite:
```bash
dotnet test
```
Confirm that all previously passing tests continue to pass. Investigate and resolve any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Replaced APIs
Review the codebase for any use of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:
- `System.Web` namespaces, which are not available in cross-platform .NET
- `HttpContext` and related types, which behave differently in ASP.NET Core
- Windows-specific APIs (e.g., registry access, `System.Drawing` without the compatibility package)
- Any third-party NuGet packages that may have been targeting .NET Framework only

### 7. Verify Static Files and Configuration
- Confirm that `wwwroot` contains all necessary static assets.
- Verify that `appsettings.json` (and `appsettings.Development.json`) are present and contain the correct configuration values previously held in `Web.config` or `App.config`.
- Check that connection strings and application settings have been properly migrated.

### 8. Test Data Access
If the project uses Entity Framework or another ORM, verify that:
- Migrations are up to date by running `dotnet ef migrations list`
- The database connection is functional by running the application against a local or staging database instance

### 9. Publish the Application
Once local validation is complete, produce a published output:
```bash
dotnet publish --configuration Release --output ./publish
```
Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.