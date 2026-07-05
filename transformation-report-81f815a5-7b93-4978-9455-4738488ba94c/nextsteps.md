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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and that the appropriate meta-packages such as `Microsoft.AspNetCore.App` are referenced.

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm expected behavior is preserved from the legacy version.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral changes introduced during migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in .NET Core or later
- `HttpContext` and related types, which may have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `System.Drawing`, which may require the `System.Drawing.Common` NuGet package and has platform limitations

### 7. Review Static Files and Configuration

Ensure that configuration files such as `appsettings.json` are present and correctly structured. Verify that any static files, views, or assets are located in the expected directories for the new project structure.

### 8. Publish the Application

Once the application has been validated locally, publish it using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.