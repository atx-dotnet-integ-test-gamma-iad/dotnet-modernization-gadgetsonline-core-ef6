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

If it is still referencing a Windows-specific framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review the test output for any failures and address them before proceeding.

### 6. Check for Runtime Dependencies on Windows-Specific APIs

Even with a successful build, the application may reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer to identify these:

```bash
dotnet add package Microsoft.DotNet.Analyzers.Compatibility
```

Review any analyzer warnings in the build output and replace or conditionally compile any platform-specific code.

### 7. Review Static Files, Configuration, and Connection Strings

- Confirm that `appsettings.json` (or equivalent) is present and correctly configured for the new hosting model.
- Verify that any database connection strings are valid and that the target database is accessible.
- Check that static file paths use `Path.Combine` and are not hardcoded with Windows-style backslashes.

### 8. Verify Data Access Layer

If the project uses Entity Framework, confirm the version being used is compatible with the target framework:

```bash
dotnet ef database update
```

Ensure migrations are present and the schema is up to date.

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application for the target runtime:

```bash
dotnet publish --configuration Release --output ./publish
```

For a specific runtime identifier (e.g., Linux x64):

```bash
dotnet publish --configuration Release -r linux-x64 --self-contained false --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm all expected files are present, including configuration files and static assets.

### 3. Test the Published Output

Run the published application directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Perform the same functional checks carried out during local validation.