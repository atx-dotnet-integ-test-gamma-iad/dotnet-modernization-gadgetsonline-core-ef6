# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework is outdated (e.g., `netcoreapp3.1`), update it to a current Long Term Support (LTS) version.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business features.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results and address any failing tests, which may indicate runtime incompatibilities not caught at compile time.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm all `System.Web` usages have been replaced with their ASP.NET Core equivalents.
- **`HttpContext` and session handling**: Verify these are accessed through dependency injection rather than static accessors.
- **Configuration**: Confirm `Web.config` has been replaced with `appsettings.json` and that configuration is read using `IConfiguration`.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that migrations are functioning correctly.

### 7. Verify Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct for the target environment and that the database schema is up to date:

```bash
dotnet ef database update
```

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 9. Deploy to Target Environment

Copy the published output to the target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed. You can verify the required runtime version from the `<TargetFramework>` value in the project file and download the corresponding runtime from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

After deployment, perform a smoke test by exercising the primary workflows of the application to confirm it operates as expected in the production environment.