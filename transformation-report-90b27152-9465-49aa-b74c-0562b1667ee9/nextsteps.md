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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas where the migrated code may behave differently at runtime.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your intended deployment environment.

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that functionality is intact after the migration.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in the legacy .NET Framework but behave differently or have been replaced in cross-platform .NET. Common areas to review include:

- `System.Web` dependencies, which are not available in cross-platform .NET and may have been replaced by ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages.
- Any Windows-specific APIs such as the registry, WCF, or remoting.
- Configuration APIs — `System.Configuration.ConfigurationManager` may require the `Microsoft.Extensions.Configuration` approach or the `System.Configuration.ConfigurationManager` NuGet package.

### 6. Verify Static Files and Views

If this is a web project, confirm that static files, Razor views, or other front-end assets are being served correctly by running the application and checking the browser output.

### 7. Check the `appsettings.json` Configuration

If the project previously relied on `Web.config` or `App.config`, verify that all configuration values have been correctly migrated to `appsettings.json` or the appropriate .NET configuration provider.

### 8. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during the migration or pre-existing issues.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all expected files, including configuration files and static assets, are present before deploying to your target environment.