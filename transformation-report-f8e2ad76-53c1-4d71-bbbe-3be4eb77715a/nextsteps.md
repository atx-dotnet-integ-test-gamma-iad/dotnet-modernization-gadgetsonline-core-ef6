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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality such as product browsing, cart operations, and any checkout or authentication flows.

### 5. Run Unit Tests

If the solution contains test projects, execute them to validate business logic and functionality:

```bash
dotnet test
```

Review test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types, which may have changed namespaces or behavior
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package
- Any Windows-specific APIs such as the registry or WCF server-side components

### 7. Validate Configuration Files

Ensure that `appsettings.json` (or equivalent) has replaced any `Web.config` or `App.config` settings that were previously used. Confirm that connection strings, app settings, and environment-specific configurations are correctly migrated.

### 8. Test Data Access

If the project uses Entity Framework or another data access layer, verify that:

- Migrations run successfully: `dotnet ef database update`
- Queries return expected results
- Connection strings point to the correct database instance

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it behaves the same as the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Verify that the application starts without errors and that core functionality remains intact.