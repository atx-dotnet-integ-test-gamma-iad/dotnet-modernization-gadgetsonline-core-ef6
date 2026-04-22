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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing packages that may not be compatible with the target .NET version.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Review the build output for any warnings, even if there are no errors. Deprecation warnings or nullable reference warnings may indicate areas of the code that need attention.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is intact:

```bash
dotnet test
```

Review test results and investigate any failures, as they may indicate behavioral differences introduced by the migration to the new .NET runtime.

### 4. Run the Application Locally

Start the application locally to confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves correctly.

### 5. Review Configuration Files

- Confirm that `appsettings.json` (and any environment-specific variants such as `appsettings.Development.json`) are present and contain the correct configuration values.
- If the legacy project used `Web.config` or `App.config`, verify that all relevant settings have been migrated to the appropriate `appsettings.json` or environment variable equivalents.
- Check that connection strings are valid and pointing to the correct database instances.

### 6. Verify Static Files and Assets

If the project is a web application, confirm that static files such as CSS, JavaScript, and images are being served correctly. Ensure the `wwwroot` folder is structured appropriately and that any build tooling for front-end assets is functioning.

### 7. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm that the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your organization's supported and intended .NET version.

### 8. Publish the Application

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all necessary files are present before deploying to the target environment.

### 9. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Confirm that the correct .NET runtime version is installed on the target machine by running:

```bash
dotnet --info
```

Start the application and perform a final round of validation against the deployed instance.