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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm that the appropriate web SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in the legacy .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace references (not available in cross-platform .NET)
- `HttpContext` and related types (should now come from `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (has limited cross-platform support; consider `SkiaSharp` or `ImageSharp` as alternatives)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm that runtime behavior matches expectations from the legacy version.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to behavioral differences introduced by the migration or pre-existing issues.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains the necessary configuration values previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly transferred.
- Check that `Web.config` transforms or `App.config` sections are no longer relied upon at runtime.

### 8. Validate Static Assets and Middleware

If this is a web application, confirm that:

- Static files are served correctly via `UseStaticFiles()` middleware.
- Routing is configured as expected in `Program.cs` or `Startup.cs`.
- Authentication and authorization middleware, if present, is correctly ordered in the request pipeline.

### 9. Test on Target Platforms

Since the goal is cross-platform support, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear during a build.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to the target environment.