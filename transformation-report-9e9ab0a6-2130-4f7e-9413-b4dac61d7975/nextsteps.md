# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the version of the .NET SDK you have installed.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Run the Application Locally

Start the application locally to confirm it runs as expected on the new runtime:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its primary features to check for runtime errors or unexpected behavior.

### 6. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or dependencies that may not behave correctly on other platforms. Common areas to review include:

- File path separators (use `Path.Combine` rather than hardcoded backslashes)
- Registry access (`Microsoft.Win32.Registry`)
- Windows-only NuGet packages or references

### 7. Review Application Configuration

Confirm that configuration files such as `appsettings.json` are present and correctly structured. If the project previously used `Web.config` or `App.config`, verify that those settings have been migrated to the appropriate .NET configuration format.

### 8. Verify Static Assets and Views

If this is a web application, manually verify that static assets, views, and routing behave correctly at runtime, as these are not always caught at compile time.

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all required files are present, including configuration files and static assets.

### 3. Test the Published Output

Run the published output directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Address any discrepancies between the development and published runtime behavior before deploying to a target environment.