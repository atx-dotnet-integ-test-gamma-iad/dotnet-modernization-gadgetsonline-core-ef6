# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to check for any runtime exceptions that would not have been caught at compile time.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures. Pay particular attention to tests covering data access, authentication, and any areas that commonly differ between .NET Framework and cross-platform .NET (e.g., `System.Web` replacements, HTTP pipeline behavior).

### 6. Check for Platform-Specific API Usage

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` tooling to scan for any remaining platform-specific API calls that may only surface on non-Windows operating systems:

```bash
dotnet tool install -g dotnet-compatibility
```

This is particularly relevant if the original project used APIs from `System.Web`, Windows Registry, or Windows-specific cryptography providers.

### 7. Verify Static Assets and Configuration

- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific overrides have been correctly migrated.
- Check that static files (CSS, JavaScript, images) are placed under the `wwwroot` folder and are being served correctly.

### 8. Test on Target Operating System

If cross-platform support is a goal, run the application on the intended non-Windows operating system (e.g., Linux) to surface any remaining platform-specific issues before deployment.

### 9. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present, then deploy the output to the target environment.