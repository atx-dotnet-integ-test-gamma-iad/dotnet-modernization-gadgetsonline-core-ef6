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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating to the latest supported LTS release.

### 4. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Check for Runtime Dependencies

Some legacy .NET Framework dependencies may have compiled successfully but can fail at runtime. Pay particular attention to:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- Windows-specific APIs such as the registry, WCF server-side components, or Windows Authentication.
- Third-party NuGet packages that may have been replaced with compatibility shims. Verify that proper cross-platform alternatives are in use.

### 6. Run the Application Locally

Start the application locally and exercise the primary workflows to confirm runtime behavior is correct:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that pages load, data access works as expected, and no unhandled exceptions occur.

### 7. Review Configuration Files

Ensure that `appsettings.json` (and any environment-specific variants such as `appsettings.Production.json`) contain all configuration values that were previously held in `Web.config` or `App.config`. Common items to check include:

- Connection strings
- Application settings keys
- Logging configuration
- Authentication settings

### 8. Validate Static Files and Bundling

If the project serves static assets, confirm that any legacy bundling and minification previously handled by `System.Web.Optimization` has been replaced with a supported alternative such as the ASP.NET Core built-in static file middleware or a front-end build tool.

### 9. Perform a Publish Dry Run

Run a publish command targeting your intended deployment environment to confirm the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to verify that all expected files, including configuration files and static assets, are present.

### 10. Deploy to Target Environment

Once all of the above steps have been completed and validated, deploy the contents of the publish output to your target environment and perform a final round of smoke testing against the deployed instance.