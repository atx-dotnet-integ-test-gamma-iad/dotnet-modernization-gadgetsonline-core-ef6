# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and address logic or API compatibility issues that may have been introduced during the migration.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File path handling**: Ensure all file paths use `Path.Combine` rather than hardcoded backslashes.
- **Configuration**: Verify that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and are being read via `IConfiguration`.
- **Authentication and Authorization middleware**: If the project uses ASP.NET Identity or cookie authentication, confirm middleware ordering in `Program.cs` or `Startup.cs` is correct.
- **Entity Framework**: If EF is used, confirm the provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and that migrations are compatible.

### 6. Run the Application Locally

Start the application and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the main workflows of the application (e.g., product browsing, cart, checkout if applicable) and confirm pages render and data loads correctly.

### 7. Check Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) are located under the `wwwroot` folder, as this is required for ASP.NET Core to serve them correctly. Files outside of `wwwroot` will not be served by default.

### 8. Review Logging Output

During local execution, review the console output for runtime warnings or errors that would not surface at build time, such as missing configuration keys, failed middleware initialization, or database connection issues.

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all expected files are present, including:

- The compiled assembly
- `appsettings.json` and any environment-specific variants (e.g., `appsettings.Production.json`)
- The `wwwroot` folder and its contents

### 3. Configure the Production Environment

Ensure the target server or hosting environment has the correct version of the .NET runtime installed. You can verify the required runtime from the `<TargetFramework>` value in the `.csproj` file. The runtime can be downloaded from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

Set the `ASPNETCORE_ENVIRONMENT` environment variable to `Production` on the target host before starting the application.