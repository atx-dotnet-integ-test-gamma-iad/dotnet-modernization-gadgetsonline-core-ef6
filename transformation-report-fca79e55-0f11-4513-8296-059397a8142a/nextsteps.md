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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures before proceeding.

### 6. Check for Runtime Compatibility Issues

Even with a clean build, runtime issues can surface. Pay attention to the following areas:

- **Database connectivity**: Confirm connection strings and database providers (e.g., Entity Framework Core) are configured correctly for cross-platform use.
- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) exist in configuration files or code. Use `Path.Combine` where applicable.
- **Authentication and session handling**: Verify middleware configuration in `Program.cs` or `Startup.cs` is correct for ASP.NET Core.
- **Static files and wwwroot**: Confirm static assets are being served correctly.

### 7. Review Configuration Files

Check `appsettings.json` and any environment-specific variants (e.g., `appsettings.Development.json`) to ensure settings previously stored in `Web.config` have been migrated correctly. Key areas include:

- Connection strings
- Logging configuration
- Application-specific settings

### 8. Validate NuGet Package Compatibility

Review all referenced NuGet packages and confirm they support the target .NET version. Packages that were designed for .NET Framework may have cross-platform equivalents that should be used instead.

```bash
dotnet list package --outdated
```

Update packages where appropriate and re-run the build and tests after doing so.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.