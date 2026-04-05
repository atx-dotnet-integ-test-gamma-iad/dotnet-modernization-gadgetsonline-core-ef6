# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages, version conflicts, or deprecated dependencies.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, obsolete APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to confirm that functionality has been preserved from the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate correctness:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they reflect genuine regressions or test code that itself requires updating for the new target framework.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which have changed significantly
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) is correctly configured and that any settings previously stored in `Web.config` or `App.config` have been migrated appropriately. Confirm that connection strings, application settings, and environment-specific values are all present and correct.

### 8. Test on the Target Platform

If the goal of the migration was to support Linux or macOS, run and test the application on those platforms explicitly to surface any remaining platform-specific issues.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents of the `./publish` folder to the target environment.