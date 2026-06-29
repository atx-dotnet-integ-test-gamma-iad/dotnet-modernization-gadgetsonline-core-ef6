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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with your deployment environment.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests before proceeding.

### 5. Verify Runtime Behavior

Run the application locally to confirm it starts and behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core workflows of the application, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features, as these are the most common sources of runtime issues after a cross-platform migration.

### 6. Check for Platform-Specific API Usage

Even without build errors, certain APIs may have been replaced with cross-platform alternatives that behave differently at runtime. Review the following areas manually:

- **File system paths**: Ensure no hardcoded backslash (`\`) path separators exist. Use `Path.Combine()` instead.
- **Registry access**: Any use of `Microsoft.Win32.Registry` will not function on Linux or macOS.
- **Windows Authentication or IIS-specific configuration**: Confirm that any authentication middleware has been updated to work with Kestrel if targeting non-Windows hosting.
- **`System.Web` references**: Confirm all `System.Web` dependencies have been fully replaced with their `Microsoft.AspNetCore` equivalents.

### 7. Review Configuration Files

Check that `web.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Confirm that connection strings, application settings, and environment-specific values are correctly represented.

### 8. Test Database Connectivity

If the application uses a database, verify that connection strings are correct and that the application can successfully connect and perform operations in the target environment.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.

### 10. Deploy to Target Environment

Copy the published output to your target server or hosting environment and verify the application runs correctly there, paying particular attention to environment-specific configuration values and any differences between development and production environments.