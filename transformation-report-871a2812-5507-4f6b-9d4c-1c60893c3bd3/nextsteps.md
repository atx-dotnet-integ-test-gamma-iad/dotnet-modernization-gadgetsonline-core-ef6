# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

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

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality such as routing, database access, and any authentication mechanisms behave correctly.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests and address them individually. Failures at this stage may indicate runtime behavior differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 6. Check for Runtime-Specific API Usage

Even with a clean build, some APIs behave differently or are unavailable at runtime on cross-platform .NET. Review the codebase for usage of the following:

- `System.Web` namespaces (not available outside of ASP.NET on .NET Framework)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-specific file path assumptions (e.g., backslash separators)
- `AppDomain` members that are not supported in .NET Core and later
- `BinaryFormatter` (deprecated and disabled by default in modern .NET)

### 7. Verify Configuration System

If the project previously used `System.Configuration` (e.g., `ConfigurationManager`, `App.config`, or `Web.config`), confirm that configuration has been migrated to the `appsettings.json` pattern using `Microsoft.Extensions.Configuration`. Ensure all environment-specific settings are present and correctly loaded.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- The data access layer (Entity Framework, Dapper, ADO.NET, etc.) functions correctly against the target database
- Any pending migrations have been applied:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Review Static Files and Web Assets

If this is a web project, verify that static files (CSS, JavaScript, images) are being served correctly and that any bundling or minification pipelines have been updated to work with the modern ASP.NET Core static file middleware.

### 10. Deploy to Target Environment

Once local validation is complete:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

2. Copy the published output to the target server.
3. Confirm the correct .NET runtime version is installed on the target machine:

```bash
dotnet --list-runtimes
```

4. Start the application and verify it responds correctly in the target environment.