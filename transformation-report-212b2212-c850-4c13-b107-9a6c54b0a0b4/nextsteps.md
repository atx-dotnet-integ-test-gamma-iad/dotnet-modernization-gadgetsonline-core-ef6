# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48` or `net472`, update it accordingly.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected compared to the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and address them individually.

### 6. Check for Runtime Dependencies on Windows-Specific APIs

Even when a project builds successfully, it may contain calls to Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Platform Compatibility Analyzer by ensuring your project file includes:

```xml
<EnableNETAnalyzers>true</EnableNETAnalyzers>
<AnalysisMode>All</AnalysisMode>
```

Address any `CA1416` warnings that surface, as these indicate platform-specific code paths.

### 7. Review `web.config` or `app.config` Usage

Legacy configuration files such as `web.config` may not function as expected in cross-platform .NET. Migrate any relevant settings to `appsettings.json` and ensure the application reads configuration through `Microsoft.Extensions.Configuration`.

### 8. Verify Static Files and wwwroot

If this is a web project, confirm that static assets are located under the `wwwroot` folder and that the project file includes:

```xml
<ItemGroup>
  <Content Include="wwwroot\**" />
</ItemGroup>
```

### 9. Database and Entity Framework Checks

If the project uses Entity Framework, confirm the correct cross-platform provider is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer` or `Npgsql` for PostgreSQL) and run any pending migrations:

```bash
dotnet ef database update
```

### 10. Test on Target Platform

If the goal is to run on Linux or macOS, deploy and run the application on that operating system to surface any remaining platform-specific issues that static analysis may not catch.