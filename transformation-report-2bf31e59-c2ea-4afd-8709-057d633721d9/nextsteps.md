# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to confirm all NuGet packages resolve correctly:
```
dotnet restore
```
Review the output for any warnings about deprecated packages or unresolved references.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:
```
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Run Unit Tests
If the solution contains test projects, execute them to verify runtime behavior has not regressed:
```
dotnet test
```
Review test output for any failures that may indicate behavioral differences introduced by the migration.

### 4. Run the Application Locally
Start the application and verify it runs as expected on your local machine:
```
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```
Manually exercise the core functionality of the application, particularly any areas that relied on Windows-specific APIs or libraries in the legacy project.

### 5. Review Replaced or Removed APIs
Check the codebase for any uses of APIs that may have been stubbed out or silently replaced during transformation. Common areas to inspect include:
- `System.Web` usages replaced with `Microsoft.AspNetCore` equivalents
- `HttpContext` access patterns
- Session and authentication middleware configuration
- Any third-party libraries that were updated to newer major versions, as these may contain breaking changes

### 6. Verify Configuration Files
Confirm that configuration has been correctly migrated:
- `web.config` settings should be represented in `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be present and pointing to the correct data sources
- Any environment-specific settings should be validated in each target environment

### 7. Database Connectivity
If the application uses a database, verify that:
- The connection string is correct for the target environment
- Any Entity Framework migrations are up to date by running:
```
dotnet ef database update
```
- Data access operations function correctly through manual or automated testing

### 8. Static Files and Assets
Confirm that static files (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and the `UseStaticFiles()` middleware must be registered in the request pipeline.

### 9. Publish the Application
Once local validation is complete, publish the application to confirm the output is correct:
```
dotnet publish --configuration Release --output ./publish
```
Review the contents of the `./publish` directory to ensure all expected files are present.

### 10. Deploy to Target Environment
Copy the published output to your target server or hosting environment and verify the application starts and responds correctly. Ensure the target machine has the appropriate .NET runtime installed, which can be confirmed with:
```
dotnet --info
```