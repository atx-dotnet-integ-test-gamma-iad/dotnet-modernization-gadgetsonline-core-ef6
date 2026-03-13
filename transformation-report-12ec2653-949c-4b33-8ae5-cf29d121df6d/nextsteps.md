# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in the legacy .NET Framework may behave differently or have been replaced in cross-platform .NET. Manually review usage of the following common problem areas:

- `System.Web` references (these are not available in cross-platform .NET and should have been replaced with `Microsoft.AspNetCore` equivalents)
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and `Startup.cs` or top-level statements)
- Windows-specific APIs such as the registry or WMI

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and behaves as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains the necessary configuration values that were previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated.

### 8. Verify Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder, as this is the expected convention in ASP.NET Core.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the contents to your target hosting environment.