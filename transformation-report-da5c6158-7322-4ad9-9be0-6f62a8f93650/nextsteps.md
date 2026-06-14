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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality such as product listings, cart operations, and any authentication flows behave as expected.

### 5. Run Existing Tests

If the solution contains a test project, execute the tests to validate business logic:

```bash
dotnet test
```

Review the results for any failing tests that may indicate runtime regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have changed or been removed in modern .NET. Common areas to check include:

- `System.Web` references, which are not available in modern .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages.
- Any use of `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Entity Framework 6 usage, which may need to be migrated to Entity Framework Core.

### 7. Verify Static Files and Configuration

Confirm that files such as `appsettings.json` are present and correctly configured, replacing any legacy `Web.config` settings that were previously used for connection strings, app settings, and other configuration values.

### 8. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment, such as IIS with the ASP.NET Core Hosting Bundle installed, or any other host that supports modern .NET.

For IIS specifically, ensure the following:

- The ASP.NET Core Hosting Bundle is installed on the server.
- The application pool is set to **No Managed Code**.
- The `web.config` generated during publish is present in the deployment directory, as it is used by IIS to configure the ASP.NET Core Module.