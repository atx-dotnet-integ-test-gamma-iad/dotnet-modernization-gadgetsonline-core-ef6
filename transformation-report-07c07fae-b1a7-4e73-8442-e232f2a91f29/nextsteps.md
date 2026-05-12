# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build
```

Verify that both commands complete with no errors or warnings that could indicate missing dependencies or unresolved references.

### 2. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`).
- No legacy `<PackageReference>` entries remain that reference Windows-only or .NET Framework-specific packages (e.g., `System.Web`, `Microsoft.AspNet.*`).
- All NuGet package versions are compatible with the target framework.

### 3. Check for Runtime-Specific Code

Even if the project builds successfully, there may be code paths that rely on Windows-specific APIs or behaviors. Search the codebase for the following and verify cross-platform compatibility:

- `Registry` access (`Microsoft.Win32.Registry`)
- Windows file path separators (hardcoded `\` instead of `Path.Combine` or `Path.DirectorySeparatorChar`)
- `System.Web` types that may have been shimmed during transformation
- Any P/Invoke calls targeting Windows-only native libraries

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Confirm the application starts without runtime exceptions.
- Navigate through the core functionality to verify expected behavior.
- Check application logs for any warnings or errors at startup.

### 5. Execute Existing Tests

If the solution contains a test project, run the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by the migration or pre-existing issues.

### 6. Verify Database Connectivity and Data Access

If the project uses Entity Framework or another data access layer:

- Confirm the connection string in `appsettings.json` (or equivalent) is correctly configured.
- Run any pending migrations if using Entity Framework Core:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Verify that CRUD operations function correctly against the target database.

### 7. Review Static Files and Configuration

- Confirm that `wwwroot` (or equivalent static file directory) is present and correctly referenced.
- Verify that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Check that any `Web.config` transforms or `appSettings` entries have been migrated to the appropriate .NET configuration system.

### 8. Publish the Application

Once the above steps are validated, produce a published output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish
```

- Review the contents of the `./publish` directory to confirm all expected files are present.
- Test the published output by running it directly to ensure the release build behaves consistently with the development build.