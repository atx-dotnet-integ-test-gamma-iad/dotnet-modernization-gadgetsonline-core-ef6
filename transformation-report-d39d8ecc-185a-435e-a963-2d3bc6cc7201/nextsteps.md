# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these can indicate compatibility issues that may surface at runtime.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the core functionality to check for any runtime errors that would not have been caught at build time.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing behavior is preserved:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures, as they may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed Windows-Specific APIs

Even without build errors, the application may rely on APIs that were available in .NET Framework but behave differently or are absent in cross-platform .NET. Areas to review manually include:

- `System.Web` usages replaced by `Microsoft.AspNetCore` equivalents
- `HttpContext` and session handling
- Any use of the Windows registry (`Microsoft.Win32.Registry`)
- `System.Drawing` (now requires the `System.Drawing.Common` package and has platform restrictions)
- Windows Communication Foundation (WCF) client or server usage

### 7. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` (or equivalent configuration files) are correct and that the application can connect and perform queries at runtime.

### 8. Review Static Files and Configuration

Ensure that any static files, configuration files (`appsettings.json`, `web.config` equivalents), and middleware configurations have been correctly migrated and are present in the expected locations for the new project structure.

### 9. Deployment

Once the above steps have been completed and the application is running correctly:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Verify the contents of the `./publish` directory to ensure all required files are present.
3. Deploy the contents of the `./publish` directory to your target hosting environment, ensuring the correct .NET runtime version is installed on the host.