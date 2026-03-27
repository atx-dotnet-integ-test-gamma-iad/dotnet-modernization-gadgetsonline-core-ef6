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

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage, which is not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` — these should now come from `Microsoft.AspNetCore.Http`
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` features

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Static Files and Configuration

- Confirm that `appsettings.json` contains the necessary configuration values previously held in `Web.config` or `App.config`.
- Verify that static files such as CSS, JavaScript, and images are placed under the `wwwroot` folder if this is an ASP.NET Core web project.
- Check that connection strings and environment-specific settings are correctly configured.

### 8. Test on Target Platforms

Since the goal is cross-platform compatibility, test the application on each platform you intend to support:

```bash
# On Linux or macOS
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Verify that file paths, line endings, and any OS-specific behavior function correctly across platforms.

### 9. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files are present.